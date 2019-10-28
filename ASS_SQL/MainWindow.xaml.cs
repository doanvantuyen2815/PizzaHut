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
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Threading;
namespace ASS_SQL
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public bool confirm { get; set; }
        public MainWindow()
        {
            InitializeComponent();
        }

        






        private void MenuNhanvien_Expanded(object sender, RoutedEventArgs e)
        {
            MenuThongke.IsExpanded = false;
        }

        private void MenuThongke_Expanded(object sender, RoutedEventArgs e)
        {
            MenuNhanvien.IsExpanded = false;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {

        }
        /*
private void TreeViewItem_PreviewMouseDown(object sender, MouseButtonEventArgs e)
{
   display.Visibility = Visibility.Visible;
}*/
    }
}
