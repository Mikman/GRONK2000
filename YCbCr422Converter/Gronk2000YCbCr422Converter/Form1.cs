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
using System.Media;

namespace Gronk2000YCbCr422Converter
{
    public partial class Form1 : Form
    {
        public const byte ycbcr_red = 0b01010111, ycbcr_green = 0b10010000, ycbcr_white = 0b11101010, ycbcr_yellow = 0b11010010, ycbcr_badr = 0b00100110; // 87, 144, 234, 210, 38

        string filePath;
        string fileContent;
        private ColorConverter.ConversionSettings preview_settings = ColorConverter.ConversionSettings.Default;

        private List<Color> paletteColors = new List<Color>() { Color.Black, Color.FromArgb(192, 192, 192), Color.FromArgb(128, 128, 128), Color.FromArgb(64, 64, 64), Color.White, Color.FromArgb(255, 0, 0), Color.FromArgb(255, 153, 0), Color.FromArgb(204, 255, 0), Color.FromArgb(51, 255, 0), Color.FromArgb(0, 255, 102), Color.FromArgb(0, 255, 255), Color.FromArgb(0, 102, 255), Color.FromArgb(51, 0, 255), Color.FromArgb(204, 0, 255), Color.FromArgb(255, 0, 153) };

        private List<PalletteGroupBox> _palettesGroups;

        internal List<PalletteGroupBox> PaletteGroups { get { if (_palettesGroups == null) _palettesGroups = new List<PalletteGroupBox>(); return _palettesGroups; } set => _palettesGroups = value; }

        public Form1()
        {
            InitializeComponent();

            this.num_field_y.Value = preview_settings.Y_bits;
            this.num_field_cb.Value = preview_settings.Cb_bits;
            this.num_field_cr.Value = preview_settings.Cr_bits;

            this.num_field_y.ValueChanged += ComponentBitsChanged;
            this.num_field_cb.ValueChanged += ComponentBitsChanged;
            this.num_field_cr.ValueChanged += ComponentBitsChanged;

            this.combo_post_conv.SelectionChangeCommitted += SelectedPostConvChanged;
            for (int i = 0; i < Enum.GetValues(typeof(ColorConverter.POST_CONV)).Length; i++)
            {
                this.combo_post_conv.Items.Add((object)Enum.GetNames(typeof(ColorConverter.POST_CONV))[i]);
            }
            this.combo_post_conv.SelectedIndex = (int)preview_settings.post_conv;

            this.combo_pre_conv.SelectionChangeCommitted += SelectedPreConvChanged;
            for (int i = 0; i < Enum.GetValues(typeof(ColorConverter.PRE_CONV)).Length; i++)
            {
                this.combo_pre_conv.Items.Add((object)Enum.GetNames(typeof(ColorConverter.PRE_CONV))[i]);
            }
            this.combo_pre_conv.SelectedIndex = (int)preview_settings.pre_conv;

            UpdatePreview();
        }

        private void SelectedPreConvChanged(object sender, EventArgs args)
        {
            preview_settings.pre_conv = (ColorConverter.PRE_CONV)((ComboBox)sender).SelectedIndex;
            UpdatePreview();
        }

        private void SelectedPostConvChanged(object sender, EventArgs args)
        {
            preview_settings.post_conv = (ColorConverter.POST_CONV)((ComboBox)sender).SelectedIndex;
            UpdatePreview();
        }

        private void ComponentBitsChanged(object sender, EventArgs args)
        {
            if ((num_field_y.Value + num_field_cb.Value + num_field_cr.Value) == 8)
            {
                this.num_field_y.BackColor = this.num_field_cb.BackColor = this.num_field_cr.BackColor = NumericUpDown.DefaultBackColor;
                this.preview_settings.Y_bits = (int)this.num_field_y.Value;
                this.preview_settings.Cb_bits = (int)this.num_field_cb.Value;
                this.preview_settings.Cr_bits = (int)this.num_field_cr.Value;
                UpdatePreview();

            }
            else
            {
                this.num_field_y.BackColor = this.num_field_cb.BackColor = this.num_field_cr.BackColor = Color.FromKnownColor(KnownColor.ControlDark);
            }
        }

        private void UpdatePreview()
        {
            this.pictureBox_preview_conv.Image = ColorConverter.ConvertImage((Bitmap) this.pictureBox_preview_og.Image, this.preview_settings);
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

        private void AddPaletteGroup(string header, Color[] col, ColorConverter.ConversionSettings settings)
        {
            PalletteGroupBox box = new PalletteGroupBox(header, col, settings);

            // Add row and move add button
            this.table_pallettes.RowCount += 1;
            this.table_pallettes.Controls.Remove(panel_add);
            this.table_pallettes.Controls.Add(panel_add, 0, this.table_pallettes.RowCount - 1);

            this.table_pallettes.Controls.Add(box);
            box.Dock = DockStyle.Fill;

            box.View.PaletteChanged += PaletteChanged;
            
            PaletteGroups.Add(box);
        }

        private void RemovePaletteGroup()
        {
            // Unsubscribe PaletteChanged eventhandler
        }

        private void PaletteChanged(object sender, PaletteColorChangedEventArgs args)
        {
            if (!args.colorAdded && paletteColors.Count > 1) {
                if (PaletteColorRemove(args.col)) UpdatePaletteColors();
            }
            else
            {

                if (color_picker.ShowDialog() == DialogResult.OK)
                {
                    if (PaletteColorAdd(color_picker.Color)) UpdatePaletteColors();
                    else SystemSounds.Asterisk.Play();
                }
                else return;
            }

            Console.WriteLine("Colors updated");
        }

        public bool PaletteColorAdd(Color col)
        {
            if (!paletteColors.Contains(col))
            {
                paletteColors.Add(col);
                return true;
            }
            return false;
        }

        public bool PaletteColorRemove(Color col)
        {
            return paletteColors.Remove(col);
        }

        public void UpdatePaletteColors()
        {
            foreach (PalletteGroupBox box in PaletteGroups)
            {
                box.UpdatePalette(paletteColors.ToArray());
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            //int width = 640, height = 480;
            //Bitmap img = new Bitmap(width, height);

            //int colors = PalletteView.Palette.Length;
            //int paletteCount = 5;

            //int sampleWidth = width / colors;
            //int paletteHeight = height / paletteCount;

            //for (int x = 0; x < width; x++)
            //{
            //    for (int y = 0; y < height; y++)
            //    {
            //        Color col = PalletteView.Palette[Clamp(x / sampleWidth, 0, colors - 1)];

            //        int paletteNum = Clamp(y / paletteHeight, 0, paletteCount - 1);

            //        CONV_METHOD method = (CONV_METHOD) paletteNum;

            //        if (y >= paletteNum * paletteHeight + paletteHeight / 2) col = YCbCrToRGB(RgbToYCbCr(col), method);
            //        if (y % paletteHeight < 3) col = Color.Black;

            //        img.SetPixel(x, y, col);
            //    }
            //}

            //pictureBox1.Image = img;
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            
        }

        private void table_pallettes_Paint(object sender, PaintEventArgs e)
        {

        }

        private void btn_pallette_add_Click(object sender, EventArgs e)
        {
            Color[] palette = this.paletteColors.ToArray();

            AddPaletteGroup("Palette" + PaletteGroups.Count, paletteColors.ToArray(), ColorConverter.ConversionSettings.Default);
        }

        public class PaletteColorChangedEventArgs : EventArgs
        {
            public readonly Color col;
            public readonly bool colorAdded;

            public PaletteColorChangedEventArgs(Color col, bool colorAdded)
            {
                this.col = col;
                this.colorAdded = colorAdded;
            }
        }
    }
}
