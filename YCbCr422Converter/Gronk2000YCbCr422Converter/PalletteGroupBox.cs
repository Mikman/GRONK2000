using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Drawing;
using Gronk2000YCbCr422Converter;

namespace Gronk2000YCbCr422Converter
{
    class PalletteGroupBox : GroupBox
    {
        private ColorConverter.ConversionSettings settings;

        private Color[] _palette = { };

        private PalletteView _view;

        private Panel pallette_panel;
        private Label label_bits;
        private Label label_y;
        private Label label_cb;
        private Label label_cr;
        private ComboBox combo_post_conv;
        private Label label_post_conv;
        private NumericUpDown num_field_cr;
        private NumericUpDown num_field_cb;
        private ComboBox combo_pre_conv;
        private Label label_pre_conv;
        private NumericUpDown num_field_y;

        internal PalletteView View { get => _view; private set => _view = value; }
        public Color[] Palette { get => _palette; private set => _palette = value; }

        private void InitializeComponent()
        {
            this.pallette_panel = new System.Windows.Forms.Panel();
            this.label_bits = new System.Windows.Forms.Label();
            this.label_y = new System.Windows.Forms.Label();
            this.label_cb = new System.Windows.Forms.Label();
            this.label_cr = new System.Windows.Forms.Label();
            this.combo_post_conv = new System.Windows.Forms.ComboBox();
            this.label_post_conv = new System.Windows.Forms.Label();
            this.num_field_cr = new System.Windows.Forms.NumericUpDown();
            this.num_field_cb = new System.Windows.Forms.NumericUpDown();
            this.num_field_y = new System.Windows.Forms.NumericUpDown();
            this.combo_pre_conv = new System.Windows.Forms.ComboBox();
            this.label_pre_conv = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.num_field_cr)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.num_field_cb)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.num_field_y)).BeginInit();
            this.SuspendLayout();
            // 
            // pallette_panel
            // 
            this.pallette_panel.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.pallette_panel.Location = new System.Drawing.Point(6, 19);
            this.pallette_panel.Name = "pallette_panel";
            this.pallette_panel.Size = new System.Drawing.Size(516, 86);
            this.pallette_panel.TabIndex = 0;
            // 
            // label_bits
            // 
            this.label_bits.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_bits.AutoSize = true;
            this.label_bits.Location = new System.Drawing.Point(528, 34);
            this.label_bits.Name = "label_bits";
            this.label_bits.Size = new System.Drawing.Size(81, 13);
            this.label_bits.TabIndex = 4;
            this.label_bits.Text = "Component Bits";
            // 
            // label_y
            // 
            this.label_y.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_y.AutoSize = true;
            this.label_y.Location = new System.Drawing.Point(612, 16);
            this.label_y.Name = "label_y";
            this.label_y.Size = new System.Drawing.Size(14, 13);
            this.label_y.TabIndex = 5;
            this.label_y.Text = "Y";
            // 
            // label_cb
            // 
            this.label_cb.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_cb.AutoSize = true;
            this.label_cb.Location = new System.Drawing.Point(654, 16);
            this.label_cb.Name = "label_cb";
            this.label_cb.Size = new System.Drawing.Size(20, 13);
            this.label_cb.TabIndex = 6;
            this.label_cb.Text = "Cb";
            // 
            // label_cr
            // 
            this.label_cr.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_cr.AutoSize = true;
            this.label_cr.Location = new System.Drawing.Point(696, 16);
            this.label_cr.Name = "label_cr";
            this.label_cr.Size = new System.Drawing.Size(17, 13);
            this.label_cr.TabIndex = 7;
            this.label_cr.Text = "Cr";
            // 
            // combo_post_conv
            // 
            this.combo_post_conv.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.combo_post_conv.FormattingEnabled = true;
            this.combo_post_conv.Location = new System.Drawing.Point(615, 58);
            this.combo_post_conv.Name = "combo_post_conv";
            this.combo_post_conv.Size = new System.Drawing.Size(120, 21);
            this.combo_post_conv.TabIndex = 8;
            // 
            // label_post_conv
            // 
            this.label_post_conv.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_post_conv.AutoSize = true;
            this.label_post_conv.Location = new System.Drawing.Point(528, 61);
            this.label_post_conv.Name = "label_post_conv";
            this.label_post_conv.Size = new System.Drawing.Size(74, 13);
            this.label_post_conv.TabIndex = 9;
            this.label_post_conv.Text = "Post. Conv.";
            // 
            // num_field_cr
            // 
            this.num_field_cr.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.num_field_cr.Location = new System.Drawing.Point(699, 32);
            this.num_field_cr.Maximum = new decimal(new int[] {
            8,
            0,
            0,
            0});
            this.num_field_cr.Name = "num_field_cr";
            this.num_field_cr.Size = new System.Drawing.Size(36, 20);
            this.num_field_cr.TabIndex = 1;
            // 
            // num_field_cb
            // 
            this.num_field_cb.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.num_field_cb.Location = new System.Drawing.Point(657, 32);
            this.num_field_cb.Maximum = new decimal(new int[] {
            8,
            0,
            0,
            0});
            this.num_field_cb.Name = "num_field_cb";
            this.num_field_cb.Size = new System.Drawing.Size(36, 20);
            this.num_field_cb.TabIndex = 2;
            // 
            // num_field_y
            // 
            this.num_field_y.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.num_field_y.Location = new System.Drawing.Point(615, 32);
            this.num_field_y.Maximum = new decimal(new int[] {
            8,
            0,
            0,
            0});
            this.num_field_y.Name = "num_field_y";
            this.num_field_y.Size = new System.Drawing.Size(36, 20);
            this.num_field_y.TabIndex = 3;
            // 
            // combo_pre_conv
            // 
            this.combo_pre_conv.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.combo_pre_conv.FormattingEnabled = true;
            this.combo_pre_conv.Location = new System.Drawing.Point(615, 84);
            this.combo_pre_conv.Name = "combo_pre_conv";
            this.combo_pre_conv.Size = new System.Drawing.Size(120, 21);
            this.combo_pre_conv.TabIndex = 8;
            // 
            // label_pre_conv
            // 
            this.label_pre_conv.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_pre_conv.AutoSize = true;
            this.label_pre_conv.Location = new System.Drawing.Point(528, 85);
            this.label_pre_conv.Name = "label_pre_conv";
            this.label_pre_conv.Size = new System.Drawing.Size(74, 13);
            this.label_pre_conv.TabIndex = 9;
            this.label_pre_conv.Text = "Pre. Conv.";
            ((System.ComponentModel.ISupportInitialize)(this.num_field_cr)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.num_field_cb)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.num_field_y)).EndInit();
            this.ResumeLayout(false);

        }

        private void SelectedPreConvChanged(object sender, EventArgs args)
        {
            settings.pre_conv = (ColorConverter.PRE_CONV)((ComboBox)sender).SelectedIndex;
            UpdatePalette();
        }

        private void SelectedPostConvChanged(object sender, EventArgs args)
        {
            settings.post_conv = (ColorConverter.POST_CONV) ((ComboBox)sender).SelectedIndex;
            UpdatePalette();
        }

        private void ComponentBitsChanged(object sender, EventArgs args)
        {
            if ((num_field_y.Value + num_field_cb.Value + num_field_cr.Value) == 8)
            {
                this.num_field_y.BackColor = this.num_field_cb.BackColor = this.num_field_cr.BackColor = NumericUpDown.DefaultBackColor;
                this.settings.Y_bits = (int) this.num_field_y.Value;
                this.settings.Cb_bits = (int) this.num_field_cb.Value;
                this.settings.Cr_bits = (int) this.num_field_cr.Value;
                UpdatePalette();

            }
            else
            {
                this.num_field_y.BackColor = this.num_field_cb.BackColor = this.num_field_cr.BackColor = Color.FromKnownColor(KnownColor.ControlDark);
            }
        }

        public PalletteGroupBox(String header, Color[] palette, ColorConverter.ConversionSettings settings)
        {
            this.Location = new System.Drawing.Point(6, 6);
            this.Width = 741;
            this.Height = 112;
            this.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;

            InitializeComponent();

            this.Controls.Add(pallette_panel);
            this.Controls.Add(label_y);
            this.Controls.Add(label_cb);
            this.Controls.Add(label_cr);
            this.Controls.Add(label_bits);
            this.Controls.Add(label_post_conv);
            this.Controls.Add(num_field_y);
            this.Controls.Add(num_field_cb);
            this.Controls.Add(num_field_cr);
            this.Controls.Add(combo_post_conv);
            this.Controls.Add(combo_pre_conv);
            this.Controls.Add(label_pre_conv);

            this.Text = header;
            this.Width = 500;

            this.settings = settings;

            this.num_field_y.Value = settings.Y_bits;
            this.num_field_cb.Value = settings.Cb_bits;
            this.num_field_cr.Value = settings.Cr_bits;

            this.num_field_y.ValueChanged += ComponentBitsChanged;
            this.num_field_cb.ValueChanged += ComponentBitsChanged;
            this.num_field_cr.ValueChanged += ComponentBitsChanged;

            this.combo_post_conv.SelectionChangeCommitted += SelectedPostConvChanged;
            for (int i = 0; i < Enum.GetValues(typeof(ColorConverter.POST_CONV)).Length; i++)
            {
                this.combo_post_conv.Items.Add((object)Enum.GetNames(typeof(ColorConverter.POST_CONV))[i]);
            }
            this.combo_post_conv.SelectedIndex = (int) settings.post_conv;

            this.combo_pre_conv.SelectionChangeCommitted += SelectedPreConvChanged;
            for (int i = 0; i < Enum.GetValues(typeof(ColorConverter.PRE_CONV)).Length; i++)
            {
                this.combo_pre_conv.Items.Add((object)Enum.GetNames(typeof(ColorConverter.PRE_CONV))[i]);
            }
            this.combo_pre_conv.SelectedIndex = (int)settings.pre_conv;

            View = new PalletteView();
            UpdatePalette(palette);
            this.pallette_panel.Controls.Add(View);
            View.Dock = DockStyle.Fill;
        }
        public void UpdatePalette(Color[] palette = null)
        {
            if (palette == null) palette = this.Palette;
            else this.Palette = palette;

            View.UpdatePallette(GenerateCompPairs(palette, settings));
        }

        public static ColorCompPair[] GenerateCompPairs(Color[] palette, ColorConverter.ConversionSettings settings)
        {
            ColorCompPair[] compPairs = new ColorCompPair[palette.Length];

            for (int i = 0; i < palette.Length; i++)
            {
                compPairs[i] = new ColorCompPair(palette[i], ColorConverter.Convert(palette[i], settings));
            }

            return compPairs;
        }
    }
}
