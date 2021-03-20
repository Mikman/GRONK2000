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
        public event EventHandler<Form1.PaletteColorChangedEventArgs> PaletteChanged;

        private void OnPaletteChanged(Form1.PaletteColorChangedEventArgs args)
        {
            PaletteChanged?.Invoke(this, args);
        }

        private void ColorMouseClick(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left) OnPaletteChanged(new Form1.PaletteColorChangedEventArgs(Color.Empty, true));
            else if (e.Button == MouseButtons.Right)
            {
                PictureBox box;

                if (sender.GetType() == typeof(PictureBox)) box = (PictureBox)sender;
                else return;

                OnPaletteChanged(new Form1.PaletteColorChangedEventArgs(box.BackColor, false));
            }
        }

        public void UpdatePallette(ColorCompPair[] pallette)
        {
            RemovePalette();

            this.RowCount = 2;
            this.ColumnCount = pallette.Length;

            for (int i = 0; i < 2; i++)
            {
                this.RowStyles.Add(new RowStyle(SizeType.Percent, 50f));
            }

            for (int i = 0; i < pallette.Length; i++)
            {
                PictureBox boxOg = CreateColorSample(pallette[i].original);
                this.Controls.Add(boxOg, i, 0);

                boxOg.MouseClick += ColorMouseClick;

                PictureBox boxConv = CreateColorSample(pallette[i].converted);
                this.Controls.Add(boxConv, i, 1);
                this.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 100f/pallette.Length));
            }
        }

        public void RemovePalette()
        {
            foreach (Control cntrl in this.Controls)
            {
                cntrl.MouseClick -= ColorMouseClick;
            }

            this.Controls.Clear();
            this.RowStyles.Clear();
            this.ColumnStyles.Clear();
        }

        private PictureBox CreateColorSample(Color color)
        {
            PictureBox box = new PictureBox();
            box.Dock = DockStyle.Fill;
            box.Margin = Padding.Empty;
            box.BackColor = color;

            return box;
        }


        public PalletteView(ColorCompPair[] pallette = null)
        {
            if (pallette != null) UpdatePallette(pallette);
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
