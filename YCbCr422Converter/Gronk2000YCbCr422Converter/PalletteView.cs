using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Drawing;

namespace Gronk2000YCbCr422Converter
{
    class PalletteView : TableLayoutPanel
    {

        public void UpdatePallette(ColorCompPair[] pallette)
        {
            this.Controls.Clear();
            this.RowCount = 2;
            this.ColumnCount = pallette.Length;

            this.RowStyles.Clear();
            this.ColumnStyles.Clear();

            for (int i = 0; i < 2; i++)
            {
                this.RowStyles.Add(new RowStyle(SizeType.Percent, 50f));
            }

            for (int i = 0; i < pallette.Length; i++)
            {
                PictureBox boxOg = CreateColorSample(pallette[i].original);
                this.Controls.Add(boxOg, i, 0);
                PictureBox boxConv = CreateColorSample(pallette[i].converted);
                this.Controls.Add(boxConv, i, 1);
                this.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 100f/pallette.Length));
            }
        }

        private PictureBox CreateColorSample(Color color)
        {
            PictureBox box = new PictureBox();
            box.Dock = DockStyle.Fill;
            box.Margin = Padding.Empty;
            box.BackColor = color;

            return box;
        }


        public PalletteView(ColorCompPair[] pallette)
        {
            UpdatePallette(new ColorCompPair[] { new ColorCompPair(Color.Red, Color.DarkRed), new ColorCompPair(Color.Green, Color.DarkGreen), new ColorCompPair(Color.Blue, Color.DarkBlue) });
        }
    }

    public struct ColorCompPair
    {
        public readonly Color original;
        public readonly Color converted;

        public ColorCompPair(Color original, Color converted)
        {
            this.original = original;
            this.converted = converted;
        }
    }
}
