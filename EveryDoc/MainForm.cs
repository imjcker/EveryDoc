using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace EveryDoc
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void textBoxSearch_Enter(object sender, KeyEventArgs e)
        {
            if(e.KeyCode == Keys.Control || e.KeyCode == Keys.Enter)
            {
                if(String.IsNullOrEmpty(((TextBox)sender).Text))
                {
                    MessageBox.Show("探索内容不能为空", "Error...");
                }
                else
                {
                    // 探索内容
                }
            }
                


        }
      
    }
}
