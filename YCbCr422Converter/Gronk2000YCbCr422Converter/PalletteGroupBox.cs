using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Gronk2000YCbCr422Converter
{
    class PalletteGroupBox : GroupBox
    {
        private Panel pallette_panel;
        private Label label_bits;
        private Label label_y;
        private Label label_cb;
        private Label label_cr;
        private ComboBox combo_method;
        private Label label_method;
        private NumericUpDown num_field_cr;
        private NumericUpDown num_field_cb;
        private NumericUpDown num_field_y;

        private void InitializeComponent()
        {
            this.pallette_panel = new System.Windows.Forms.Panel();
            this.label_bits = new System.Windows.Forms.Label();
            this.label_y = new System.Windows.Forms.Label();
            this.label_cb = new System.Windows.Forms.Label();
            this.label_cr = new System.Windows.Forms.Label();
            this.combo_method = new System.Windows.Forms.ComboBox();
            this.label_method = new System.Windows.Forms.Label();
            this.num_field_cr = new System.Windows.Forms.NumericUpDown();
            this.num_field_cb = new System.Windows.Forms.NumericUpDown();
            this.num_field_y = new System.Windows.Forms.NumericUpDown();
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
            this.pallette_panel.Size = new System.Drawing.Size(516, 60);
            this.pallette_panel.TabIndex = 0;
            // 
            // label_bits
            // 
            this.label_bits.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_bits.AutoSize = true;
            this.label_bits.Location = new System.Drawing.Point(511, 34);
            this.label_bits.Name = "label_bits";
            this.label_bits.Size = new System.Drawing.Size(81, 13);
            this.label_bits.TabIndex = 4;
            this.label_bits.Text = "Component Bits";
            // 
            // label_y
            // 
            this.label_y.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_y.AutoSize = true;
            this.label_y.Location = new System.Drawing.Point(595, 16);
            this.label_y.Name = "label_y";
            this.label_y.Size = new System.Drawing.Size(14, 13);
            this.label_y.TabIndex = 5;
            this.label_y.Text = "Y";
            // 
            // label_cb
            // 
            this.label_cb.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_cb.AutoSize = true;
            this.label_cb.Location = new System.Drawing.Point(637, 16);
            this.label_cb.Name = "label_cb";
            this.label_cb.Size = new System.Drawing.Size(20, 13);
            this.label_cb.TabIndex = 6;
            this.label_cb.Text = "Cb";
            // 
            // label_cr
            // 
            this.label_cr.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_cr.AutoSize = true;
            this.label_cr.Location = new System.Drawing.Point(679, 16);
            this.label_cr.Name = "label_cr";
            this.label_cr.Size = new System.Drawing.Size(17, 13);
            this.label_cr.TabIndex = 7;
            this.label_cr.Text = "Cr";
            // 
            // combo_method
            // 
            this.combo_method.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.combo_method.FormattingEnabled = true;
            this.combo_method.Location = new System.Drawing.Point(598, 58);
            this.combo_method.Name = "combo_method";
            this.combo_method.Size = new System.Drawing.Size(120, 21);
            this.combo_method.TabIndex = 8;
            // 
            // label_method
            // 
            this.label_method.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_method.AutoSize = true;
            this.label_method.Location = new System.Drawing.Point(511, 61);
            this.label_method.Name = "label_method";
            this.label_method.Size = new System.Drawing.Size(74, 13);
            this.label_method.TabIndex = 9;
            this.label_method.Text = "Conv. Method";
            // 
            // num_field_cr
            // 
            this.num_field_cr.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.num_field_cr.Location = new System.Drawing.Point(682, 32);
            this.num_field_cr.Name = "num_field_cr";
            this.num_field_cr.Size = new System.Drawing.Size(36, 20);
            this.num_field_cr.TabIndex = 1;
            // 
            // num_field_cb
            // 
            this.num_field_cb.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.num_field_cb.Location = new System.Drawing.Point(640, 32);
            this.num_field_cb.Name = "num_field_cb";
            this.num_field_cb.Size = new System.Drawing.Size(36, 20);
            this.num_field_cb.TabIndex = 2;
            // 
            // num_field_y
            // 
            this.num_field_y.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.num_field_y.Location = new System.Drawing.Point(598, 32);
            this.num_field_y.Name = "num_field_y";
            this.num_field_y.Size = new System.Drawing.Size(36, 20);
            this.num_field_y.TabIndex = 3;
            ((System.ComponentModel.ISupportInitialize)(this.num_field_cr)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.num_field_cb)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.num_field_y)).EndInit();
            this.ResumeLayout(false);

        }

        public PalletteGroupBox(String header, ColorCompPair[] compPair)
        {
            InitializeComponent();

            this.Controls.Add(pallette_panel);
            this.Controls.Add(label_y);
            this.Controls.Add(label_cb);
            this.Controls.Add(label_cr);
            this.Controls.Add(label_bits);
            this.Controls.Add(label_method);
            this.Controls.Add(num_field_y);
            this.Controls.Add(num_field_cb);
            this.Controls.Add(num_field_cb);
            this.Controls.Add(combo_method);

            this.Text = header;

            this.Height = 86;
            this.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            
            PalletteView view = new PalletteView(compPair);
            this.pallette_panel.Controls.Add(view);
            view.Dock = DockStyle.Fill;
            view.Update();
            
        }
    }
}
