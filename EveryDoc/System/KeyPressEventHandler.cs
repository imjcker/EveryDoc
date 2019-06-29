using System.Windows.Forms;

namespace System
{
    internal class KeyPressEventHandler
    {
        private Action<object, KeyEventArgs> textBoxSearch_TextChanged;

        public KeyPressEventHandler(Action<object, KeyEventArgs> textBoxSearch_TextChanged)
        {
            this.textBoxSearch_TextChanged = textBoxSearch_TextChanged;
        }
    }
}