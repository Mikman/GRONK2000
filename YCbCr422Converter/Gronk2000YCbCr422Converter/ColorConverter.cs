using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;

namespace Gronk2000YCbCr422Converter
{
    static class ColorConverter
    {
        public enum POST_CONV
        {
            NONE,
            M2,
            J,
            COMBI,
            J2
        }

        public enum PRE_CONV
        {
            NONE,
            ROUND
        }

        public static Color YCbCrToRGB(byte yCbCr, ConversionSettings settings)
        {
            // https://en.wikipedia.org/wiki/YCbCr#ITU-R_BT.601_conversion
            // Y (4 bit) | Cb (2 bit) | Cr (2 bit)
            int Y, Cb, Cr, Y_bits = settings.Y_bits, Cb_bits = settings.Cb_bits, Cr_bits = settings.Cr_bits;

            Y = ((int)(yCbCr & xMSB(Y_bits)));
            Cb = ((int)((yCbCr << (Y_bits)) & xMSB(Cb_bits)));
            Cr = ((int)((yCbCr << (Y_bits+Cb_bits)) & xMSB(Cr_bits)));

            switch (settings.post_conv)
            {
                case POST_CONV.M2:
                    Y = (int)((float)Y * (255f / (float) xMSB(Y_bits)));
                    Cb = (int)((float)Cb * (255f / (float) xMSB(Cb_bits)));
                    Cr = (int)((float)Cr * (255f / (float) xMSB(Cr_bits)));
                    break;
                case POST_CONV.J:
                    Cb |= (128 >> Cb_bits);
                    Cr |= (128 >> Cr_bits);
                    break;
                case POST_CONV.COMBI:
                    Y = (int)((float)Y * (255f / (float)xMSB(Y_bits)));
                    Cb |= (128 >> Cb_bits);
                    Cr |= (128 >> Cr_bits);
                    break;
                case POST_CONV.J2:
                    Y |= (128 >> Y_bits);
                    Cb |= (128 >> Cb_bits);
                    Cr |= (128 >> Cr_bits);
                    break;
                default: break;
            }


            int R, G, B;
            R = Clamp((int)((298.082f * Y) / 256 + (408.583f * Cr) / 256 - 222.921), 0, 255);
            G = Clamp((int)((298.082f * Y) / 256 - (100.291f * Cb) / 256 - (208.120f * Cr) / 256 + 135.576), 0, 255);
            B = Clamp((int)((298.082f * Y) / 256 + (516.412f * Cb) / 256 - 276.836), 0, 255);

            return Color.FromArgb(R, G, B);
        }

        public static byte RgbToYCbCr(Color rgb, ConversionSettings settings)
        {
            int R = rgb.R, G = rgb.G, B = rgb.B;

            byte Y, Cb, Cr;

            switch (settings.pre_conv)
            {
                case PRE_CONV.ROUND:
                    Y = (byte)Math.Round(16f + ((65.481f * (float)R + 128.553f * (float)G + 24.966f * (float)B) / 255f));
                    Cb = (byte)Math.Round(128f + ((-37.797f * (float)R - 74.203f * (float)G + 112f * (float)B) / 255f));
                    Cr = (byte)Math.Round(128f + ((112f * (float)R - 93.786f * (float)G - 18.214f * (float)B) / 255f));
                    break;
                default:
                    Y = (byte)(16f + ((65.481f * (float)R + 128.553f * (float)G + 24.966f * (float)B) / 255f));
                    Cb = (byte)(128f + ((-37.797f * (float)R - 74.203f * (float)G + 112f * (float)B) / 255f));
                    Cr = (byte)(128f + ((112f * (float)R - 93.786f * (float)G - 18.214f * (float)B) / 255f));
                    break;
            }

            Y &= xMSB(settings.Y_bits);
            Cb &= xMSB(settings.Cb_bits);
            Cr &= xMSB(settings.Cr_bits);

            return (byte)(Y | (Cb >> settings.Y_bits) | (Cr >> (settings.Y_bits + settings.Cb_bits)));
        }

        public static Color Convert(Color col, ConversionSettings settings)
        {
            return YCbCrToRGB(RgbToYCbCr(col, settings), settings);
        }

        public static Bitmap ConvertImage(Bitmap original, ConversionSettings settings)
        {
            Bitmap converted = new Bitmap(original.Width, original.Height);

            for (int x = 0; x < original.Width; x++)
            {
                for (int y = 0; y < original.Height; y++)
                {
                    converted.SetPixel(x, y, Convert(original.GetPixel(x, y), settings));
                }
            }

            return converted;
        }

        private static int Clamp(int input, int min, int max)
        {
            if (input > max) input = max;
            if (input < min) input = min;
            return input;
        }

        /// <summary>
        /// Returns byte with desired amount of high most significant bits.
        /// </summary>
        /// <param name="bits"></param>
        /// <returns></returns>
        public static byte xMSB(int bits)
        {
            if (bits < 0 || bits > 8) throw new ArgumentException();

            byte output = 0;
            for (int i = 0; i < bits; i++)
            {
                output |= (byte) (1 << 7-i);
            }
            return output;
        }

        /// <summary>
        /// Returns byte with desired amount of high least significant bits.
        /// </summary>
        /// <param name="bits"></param>
        /// <returns></returns>
        public static byte xLSB(int bits)
        {
            if (bits < 0 || bits > 8) throw new ArgumentException();

            byte output = 0;
            for (int i = 0; i < bits; i++)
            {
                output |= (byte)(1 << i);
            }
            return output;
        }


        public struct ConversionSettings
        {
            public int Y_bits, Cb_bits, Cr_bits;
            public PRE_CONV pre_conv;
            public POST_CONV post_conv;

            public ConversionSettings(POST_CONV post_conv, PRE_CONV pre_conv, int Y_bits, int Cb_bits, int Cr_bits)
            {
                if ((Y_bits + Cb_bits + Cr_bits) != 8) throw new System.ArgumentException("YCbCr bit components must add up to 8.");

                this.Y_bits = Y_bits;
                this.Cb_bits = Cb_bits;
                this.Cr_bits = Cr_bits;
                this.post_conv = post_conv;
                this.pre_conv = pre_conv;
            }

            public static ConversionSettings Default = new ConversionSettings(POST_CONV.NONE, PRE_CONV.NONE, 4, 2, 2);
        }
    }
}
