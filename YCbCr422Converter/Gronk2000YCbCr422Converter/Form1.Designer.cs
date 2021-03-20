
namespace Gronk2000YCbCr422Converter
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.tab_container = new System.Windows.Forms.TabControl();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.table_pallettes = new System.Windows.Forms.TableLayoutPanel();
            this.panel_add = new System.Windows.Forms.Panel();
            this.btn_pallette_add = new System.Windows.Forms.Button();
            this.tabPage2 = new System.Windows.Forms.TabPage();
            this.color_picker = new System.Windows.Forms.ColorDialog();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.btn_preview_load = new System.Windows.Forms.Button();
            this.combo_post_conv = new System.Windows.Forms.ComboBox();
            this.combo_pre_conv = new System.Windows.Forms.ComboBox();
            this.label_pre_conv = new System.Windows.Forms.Label();
            this.num_field_cr = new System.Windows.Forms.NumericUpDown();
            this.label_post_conv = new System.Windows.Forms.Label();
            this.label_cr = new System.Windows.Forms.Label();
            this.label_cb = new System.Windows.Forms.Label();
            this.label_y = new System.Windows.Forms.Label();
            this.label_bits = new System.Windows.Forms.Label();
            this.num_field_cb = new System.Windows.Forms.NumericUpDown();
            this.num_field_y = new System.Windows.Forms.NumericUpDown();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.tab_container.SuspendLayout();
            this.tabPage1.SuspendLayout();
            this.table_pallettes.SuspendLayout();
            this.panel_add.SuspendLayout();
            this.tabPage2.SuspendLayout();
            this.tableLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.num_field_cr)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.num_field_cb)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.num_field_y)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            this.SuspendLayout();
            // 
            // openFileDialog
            // 
            this.openFileDialog.FileName = "openFileDialog1";
            // 
            // tab_container
            // 
            this.tab_container.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tab_container.Controls.Add(this.tabPage1);
            this.tab_container.Controls.Add(this.tabPage2);
            this.tab_container.Location = new System.Drawing.Point(12, 12);
            this.tab_container.Name = "tab_container";
            this.tab_container.SelectedIndex = 0;
            this.tab_container.Size = new System.Drawing.Size(761, 482);
            this.tab_container.TabIndex = 1;
            // 
            // tabPage1
            // 
            this.tabPage1.Controls.Add(this.table_pallettes);
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(753, 456);
            this.tabPage1.TabIndex = 2;
            this.tabPage1.Text = "Palette";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // table_pallettes
            // 
            this.table_pallettes.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.table_pallettes.AutoScroll = true;
            this.table_pallettes.ColumnCount = 1;
            this.table_pallettes.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
            this.table_pallettes.Controls.Add(this.panel_add, 0, 0);
            this.table_pallettes.Location = new System.Drawing.Point(6, 6);
            this.table_pallettes.Name = "table_pallettes";
            this.table_pallettes.RowCount = 1;
            this.table_pallettes.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.table_pallettes.Size = new System.Drawing.Size(741, 444);
            this.table_pallettes.TabIndex = 2;
            this.table_pallettes.Paint += new System.Windows.Forms.PaintEventHandler(this.table_pallettes_Paint);
            // 
            // panel_add
            // 
            this.panel_add.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.panel_add.Controls.Add(this.btn_pallette_add);
            this.panel_add.Location = new System.Drawing.Point(3, 3);
            this.panel_add.Name = "panel_add";
            this.panel_add.Size = new System.Drawing.Size(735, 60);
            this.panel_add.TabIndex = 10;
            // 
            // btn_pallette_add
            // 
            this.btn_pallette_add.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.btn_pallette_add.AutoSize = true;
            this.btn_pallette_add.Location = new System.Drawing.Point(297, 19);
            this.btn_pallette_add.Name = "btn_pallette_add";
            this.btn_pallette_add.Size = new System.Drawing.Size(139, 23);
            this.btn_pallette_add.TabIndex = 0;
            this.btn_pallette_add.Text = "Add";
            this.btn_pallette_add.UseVisualStyleBackColor = true;
            this.btn_pallette_add.Click += new System.EventHandler(this.btn_pallette_add_Click);
            // 
            // tabPage2
            // 
            this.tabPage2.Controls.Add(this.combo_post_conv);
            this.tabPage2.Controls.Add(this.combo_pre_conv);
            this.tabPage2.Controls.Add(this.label_pre_conv);
            this.tabPage2.Controls.Add(this.num_field_cr);
            this.tabPage2.Controls.Add(this.label_post_conv);
            this.tabPage2.Controls.Add(this.label_cr);
            this.tabPage2.Controls.Add(this.label_cb);
            this.tabPage2.Controls.Add(this.label_y);
            this.tabPage2.Controls.Add(this.label_bits);
            this.tabPage2.Controls.Add(this.num_field_cb);
            this.tabPage2.Controls.Add(this.num_field_y);
            this.tabPage2.Controls.Add(this.btn_preview_load);
            this.tabPage2.Controls.Add(this.tableLayoutPanel1);
            this.tabPage2.Location = new System.Drawing.Point(4, 22);
            this.tabPage2.Name = "tabPage2";
            this.tabPage2.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage2.Size = new System.Drawing.Size(753, 456);
            this.tabPage2.TabIndex = 3;
            this.tabPage2.Text = "Preview";
            this.tabPage2.UseVisualStyleBackColor = true;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tableLayoutPanel1.ColumnCount = 2;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.Controls.Add(this.pictureBox1, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.pictureBox2, 1, 0);
            this.tableLayoutPanel1.Location = new System.Drawing.Point(6, 6);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 1;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(608, 444);
            this.tableLayoutPanel1.TabIndex = 0;
            // 
            // btn_preview_load
            // 
            this.btn_preview_load.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btn_preview_load.Location = new System.Drawing.Point(623, 6);
            this.btn_preview_load.Name = "btn_preview_load";
            this.btn_preview_load.Size = new System.Drawing.Size(124, 23);
            this.btn_preview_load.TabIndex = 1;
            this.btn_preview_load.Text = "Load";
            this.btn_preview_load.UseVisualStyleBackColor = true;
            // 
            // combo_post_conv
            // 
            this.combo_post_conv.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.combo_post_conv.FormattingEnabled = true;
            this.combo_post_conv.Location = new System.Drawing.Point(623, 105);
            this.combo_post_conv.Name = "combo_post_conv";
            this.combo_post_conv.Size = new System.Drawing.Size(120, 21);
            this.combo_post_conv.TabIndex = 17;
            // 
            // combo_pre_conv
            // 
            this.combo_pre_conv.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.combo_pre_conv.FormattingEnabled = true;
            this.combo_pre_conv.Location = new System.Drawing.Point(623, 145);
            this.combo_pre_conv.Name = "combo_pre_conv";
            this.combo_pre_conv.Size = new System.Drawing.Size(120, 21);
            this.combo_pre_conv.TabIndex = 18;
            // 
            // label_pre_conv
            // 
            this.label_pre_conv.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_pre_conv.AutoSize = true;
            this.label_pre_conv.Location = new System.Drawing.Point(620, 129);
            this.label_pre_conv.Name = "label_pre_conv";
            this.label_pre_conv.Size = new System.Drawing.Size(57, 13);
            this.label_pre_conv.TabIndex = 19;
            this.label_pre_conv.Text = "Pre. Conv.";
            // 
            // num_field_cr
            // 
            this.num_field_cr.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.num_field_cr.Location = new System.Drawing.Point(707, 66);
            this.num_field_cr.Maximum = new decimal(new int[] {
            8,
            0,
            0,
            0});
            this.num_field_cr.Name = "num_field_cr";
            this.num_field_cr.Size = new System.Drawing.Size(36, 20);
            this.num_field_cr.TabIndex = 10;
            // 
            // label_post_conv
            // 
            this.label_post_conv.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_post_conv.AutoSize = true;
            this.label_post_conv.Location = new System.Drawing.Point(620, 89);
            this.label_post_conv.Name = "label_post_conv";
            this.label_post_conv.Size = new System.Drawing.Size(62, 13);
            this.label_post_conv.TabIndex = 20;
            this.label_post_conv.Text = "Post. Conv.";
            // 
            // label_cr
            // 
            this.label_cr.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_cr.AutoSize = true;
            this.label_cr.Location = new System.Drawing.Point(704, 50);
            this.label_cr.Name = "label_cr";
            this.label_cr.Size = new System.Drawing.Size(17, 13);
            this.label_cr.TabIndex = 16;
            this.label_cr.Text = "Cr";
            // 
            // label_cb
            // 
            this.label_cb.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_cb.AutoSize = true;
            this.label_cb.Location = new System.Drawing.Point(662, 50);
            this.label_cb.Name = "label_cb";
            this.label_cb.Size = new System.Drawing.Size(20, 13);
            this.label_cb.TabIndex = 15;
            this.label_cb.Text = "Cb";
            // 
            // label_y
            // 
            this.label_y.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_y.AutoSize = true;
            this.label_y.Location = new System.Drawing.Point(620, 50);
            this.label_y.Name = "label_y";
            this.label_y.Size = new System.Drawing.Size(14, 13);
            this.label_y.TabIndex = 14;
            this.label_y.Text = "Y";
            // 
            // label_bits
            // 
            this.label_bits.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label_bits.AutoSize = true;
            this.label_bits.Location = new System.Drawing.Point(620, 32);
            this.label_bits.Name = "label_bits";
            this.label_bits.Size = new System.Drawing.Size(81, 13);
            this.label_bits.TabIndex = 13;
            this.label_bits.Text = "Component Bits";
            // 
            // num_field_cb
            // 
            this.num_field_cb.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.num_field_cb.Location = new System.Drawing.Point(665, 66);
            this.num_field_cb.Maximum = new decimal(new int[] {
            8,
            0,
            0,
            0});
            this.num_field_cb.Name = "num_field_cb";
            this.num_field_cb.Size = new System.Drawing.Size(36, 20);
            this.num_field_cb.TabIndex = 11;
            // 
            // num_field_y
            // 
            this.num_field_y.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.num_field_y.Location = new System.Drawing.Point(623, 66);
            this.num_field_y.Maximum = new decimal(new int[] {
            8,
            0,
            0,
            0});
            this.num_field_y.Name = "num_field_y";
            this.num_field_y.Size = new System.Drawing.Size(36, 20);
            this.num_field_y.TabIndex = 12;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Location = new System.Drawing.Point(3, 3);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(100, 50);
            this.pictureBox1.TabIndex = 0;
            this.pictureBox1.TabStop = false;
            // 
            // pictureBox2
            // 
            this.pictureBox2.Location = new System.Drawing.Point(307, 3);
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new System.Drawing.Size(100, 50);
            this.pictureBox2.TabIndex = 1;
            this.pictureBox2.TabStop = false;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(785, 506);
            this.Controls.Add(this.tab_container);
            this.Name = "Form1";
            this.Text = "Form1";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
            this.Load += new System.EventHandler(this.Form1_Load);
            this.tab_container.ResumeLayout(false);
            this.tabPage1.ResumeLayout(false);
            this.table_pallettes.ResumeLayout(false);
            this.panel_add.ResumeLayout(false);
            this.panel_add.PerformLayout();
            this.tabPage2.ResumeLayout(false);
            this.tabPage2.PerformLayout();
            this.tableLayoutPanel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.num_field_cr)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.num_field_cb)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.num_field_y)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.OpenFileDialog openFileDialog;
        private System.Windows.Forms.TabControl tab_container;
        private System.Windows.Forms.ColorDialog color_picker;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.TabPage tabPage2;
        private System.Windows.Forms.TableLayoutPanel table_pallettes;
        private System.Windows.Forms.Panel panel_add;
        private System.Windows.Forms.Button btn_pallette_add;
        private System.Windows.Forms.Button btn_preview_load;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.ComboBox combo_post_conv;
        private System.Windows.Forms.ComboBox combo_pre_conv;
        private System.Windows.Forms.Label label_pre_conv;
        private System.Windows.Forms.NumericUpDown num_field_cr;
        private System.Windows.Forms.Label label_post_conv;
        private System.Windows.Forms.Label label_cr;
        private System.Windows.Forms.Label label_cb;
        private System.Windows.Forms.Label label_y;
        private System.Windows.Forms.Label label_bits;
        private System.Windows.Forms.NumericUpDown num_field_cb;
        private System.Windows.Forms.NumericUpDown num_field_y;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.PictureBox pictureBox2;
    }
}

