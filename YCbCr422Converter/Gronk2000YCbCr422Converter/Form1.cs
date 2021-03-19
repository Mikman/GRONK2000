using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;

namespace Gronk2000YCbCr422Converter
{
    public partial class Form1 : Form
    {
        public const byte ycbcr_red = 0b01010111, ycbcr_green = 0b10010000, ycbcr_white = 0b11101010, ycbcr_yellow = 0b11010010, ycbcr_badr = 0b00100110; // 87, 144, 234, 210, 38

        private Color[] palette = new Color[] { Color.Red, Color.FromArgb(0, 255, 0), Color.Blue, Color.Black, Color.White, Color.Yellow, Color.Brown, Color.Cyan, Color.Orange, Color.Pink, Color.SandyBrown };

        string filePath;
        string fileContent;

        enum CONV_METHOD
        {
            NONE,
            M2,
            J,
            COMBI,
            J2
        }

        public Form1()
        {
            InitializeComponent();
        }

        private void btn_read_Click(object sender, EventArgs e)
        {
            ReadFile();

            Console.WriteLine("Read from file (" + filePath + "):\n" + fileContent);
        }

        private void ReadFile()
        {
            using (OpenFileDialog dialog = new OpenFileDialog())
            {
                dialog.RestoreDirectory = true;

                if (dialog.ShowDialog() == DialogResult.OK)
                {
                    filePath = dialog.FileName;

                    Stream fileStream = dialog.OpenFile();

                    using (StreamReader reader = new StreamReader(fileStream))
                    {
                        fileContent = reader.ReadToEnd();
                    }
                }
            }
        }

        static Color YCbCrToRGB(byte yCbCr, CONV_METHOD conv = CONV_METHOD.M2)
        {
            // https://en.wikipedia.org/wiki/YCbCr#ITU-R_BT.601_conversion
            // Y (4 bit) | Cb (2 bit) | Cr (2 bit)
            int Y, Cb, Cr;
            Y = ((int)(yCbCr & 0xF0));
            Cb = ((int)((yCbCr << 4) & 0b11000000));
            Cr = ((int)((yCbCr << 6) & 0b11000000));

            switch (conv)
            {
                case CONV_METHOD.M2:
                    Y = (int) ((float) Y * (255f / 240f));
                    Cb = (int) ((float) Cb * (255f / 192f));
                    Cr = (int) ((float) Cr * (255f / 192f));
                    break;
                case CONV_METHOD.J:
                    Cb |= 32;
                    Cr |= 32;
                    break;
                case CONV_METHOD.COMBI:
                    Y = (int)((float)Y * (255f / 240f));
                    Cb |= 32;
                    Cr |= 32;
                    break;
                case CONV_METHOD.J2:
                    Y = (int)((float)Y * (255f / 240f));
                    Cb |= 32;
                    Cr |= 32;
                    break;
                default: break;
            }
            
            
            int R, G, B;
            R = Clamp((int)((298.082f * Y) / 256 + (408.583f * Cr) / 256 - 222.921), 0, 255);
            G = Clamp((int)((298.082f * Y) / 256 - (100.291f * Cb) / 256 - (208.120f * Cr) / 256 + 135.576), 0, 255);
            B = Clamp((int)((298.082f * Y) / 256 + (516.412f * Cb) / 256 - 276.836), 0, 255);

            return Color.FromArgb(R, G, B);
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            int width = 640, height = 480;
            Bitmap img = new Bitmap(width, height);

            int colors = palette.Length;
            int paletteCount = 4;

            int sampleWidth = width / colors;
            int paletteHeight = height / paletteCount;
            

            for (int x = 0; x < width; x++)
            {
                for (int y = 0; y < height; y++)
                {
                    Color col = palette[Clamp(x / sampleWidth, 0, colors - 1)];

                    int paletteNum = Clamp(y / paletteHeight, 0, paletteCount - 1);

                    CONV_METHOD method = (CONV_METHOD) paletteNum;

                    if (y >= paletteNum * paletteHeight + paletteHeight / 2) col = YCbCrToRGB(RgbToYCbCr(col), method);
                    if (y % paletteHeight < 3) col = Color.Black;

                    img.SetPixel(x, y, col);
                }
            }

            pictureBox1.Image = img;

            Console.WriteLine("Converted color value: " + RgbToYCbCr(Color.Red).ToString());
            Console.WriteLine("Converted color value: " + RgbToYCbCr(Color.FromArgb(0, 255, 0)).ToString());
            Console.WriteLine("Converted color value: " + RgbToYCbCr(Color.White).ToString());
            Console.WriteLine("Converted color value: " + RgbToYCbCr(Color.Yellow).ToString());
        }

        static int Clamp(int input, int min, int max)
        {
            if (input > max) input = max;
            if (input < min) input = min;
            return input;
        }

        static byte RgbToYCbCr(Color rgb)
        {
            int R = rgb.R, G = rgb.G, B = rgb.B;

            byte Y, Cb, Cr;
            Y =  (byte) (16 + ((65.481f * (float) R + 128.553f * (float) G + 24.966f * (float) B) / 255f));
            Cb = (byte) (128 + ((-37.797f * (float) R - 74.203f * (float) G + 112f * (float) B) / 255f));
            Cr = (byte) (128 + ((112f * (float) R - 93.786f * (float) G - 18.214f * (float) B) / 255f));

            Y &= 0xF0;
            Cb &= 0b11000000;
            Cr &= 0b11000000;

            return (byte) (Y | (Cb >> 4) | (Cr >> 6));
        }

        private class RgbYcbcrPair
        {
            private readonly Color rgb_original;
            private readonly Color rgb_converted;
            private readonly byte YCbCr;

            

            public RgbYcbcrPair(Color rgb, CONV_METHOD conv = CONV_METHOD.M2)
            {
                rgb_original = rgb;
                YCbCr = RgbToYCbCr(rgb_original);
                rgb_converted = YCbCrToRGB(YCbCr, conv);
            }

            //public RgbYcbcrPair(int r, int g, int b)
            //{
            //    RgbYcbcrPair(Color.FromArgb(r, g, b));
            //}
        }
    }
}
