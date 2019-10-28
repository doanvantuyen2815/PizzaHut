using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace ASS_SQL
{
    /// <summary>
    /// Interaction logic for LoginWindow.xaml
    /// </summary>
    public partial class LoginWindow : Window
    {
        public LoginWindow()
        {
            InitializeComponent();
        }
        private void login_button_MouseEnter(object sender, MouseEventArgs e)
        {
            var bc = new BrushConverter();
            login_button.Background = (Brush)bc.ConvertFrom("#FF171616");
            login_button_1.Background = (Brush)bc.ConvertFrom("#FF171616");
            
        }

        private void login_button_MouseLeave(object sender, MouseEventArgs e)
        {
            var bc = new BrushConverter();
            login_button.Background = (Brush)bc.ConvertFrom("#FFE20F0F");
            login_button_1.Background = (Brush)bc.ConvertFrom("#FFE20F0F");
            
            
        }

        private void login_button_Click(object sender, RoutedEventArgs e)
        {
            login_button.Visibility = Visibility.Collapsed;
            button_login.Visibility = Visibility.Visible;
        }

        
    }
}
