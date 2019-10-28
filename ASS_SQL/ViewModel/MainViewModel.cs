using ASS_SQL.Data;
using ASS_SQL.Model;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace ASS_SQL.ViewModel
{
    class MainViewModel:BaseViewModel
    {
        
        public bool Isloaded = false;
        public bool ButtonVisibility { get; set; }
        private ObservableCollection<User> _ListNhanVien;
        private ObservableCollection<Search_NhanVien_Result> _ListSearch;
        private ObservableCollection<Search_NhanVien_Result> _ListSearch2;
        private ObservableCollection<Search_NhanVien_Result> _ListSearch3;
        private ObservableCollection<Search_Item1_Result> _ListSearchItem;
        private ObservableCollection<Search_Combo_Result> _ListSearchCombo;
        private ObservableCollection<OrderDetailTemp> _ListOrderTemp;
        private ObservableCollection<OrderDetailComboTemp> _ListComboTemp;
        private ObservableCollection<ThongKeTheoDonHang_Result> _ListThongKeDonHang;
        private ObservableCollection<ThongKeTheoKhachHang_Result> _ListThongKeKhachHang;
        private ObservableCollection<Search_Customer_Result> _ListSearchCustomer;
        private Search_Item1_Result _SelectedItem;
        private Search_Customer_Result _SelectedCustomer;
        public Search_Item1_Result SelectedItem { get => _SelectedItem;set { _SelectedItem = value; } }
        private Search_Combo_Result _SelectedCombo;
        public Search_Combo_Result SelectedCombo{ get => _SelectedCombo; set { _SelectedCombo = value; } }
        private Search_NhanVien_Result _SelectedNhanVien;
        public Search_NhanVien_Result SelectedNhanVien { get => _SelectedNhanVien;
            set
            {
                _SelectedNhanVien = value;
                OnPropertyChanged();
                if (SelectedNhanVien != null)
                {
                    DisplayName = SelectedNhanVien.DisplayName;
                    ID = SelectedNhanVien.ID;
                    Phone = SelectedNhanVien.Phone;
                    Birthday = SelectedNhanVien.Birthday;
                }
            }
        }
        private Search_NhanVien_Result _SelectedNhanVienDelete;
        public Search_NhanVien_Result SelectedNhanVienDelete
        {
            get => _SelectedNhanVienDelete;
            set
            {
                _SelectedNhanVienDelete = value;
                OnPropertyChanged();

            }
        }
        public Search_Customer_Result SelectedCustomer
        {
            get => _SelectedCustomer;
            set
            {
                _SelectedCustomer = value;
                OnPropertyChanged();

            }
        }
        private string _DisplayName;
        public string DisplayName { get => _DisplayName;set { _DisplayName = value;OnPropertyChanged(); } }
        private int _ID;
        public int ID { get => _ID; set { _ID = value; OnPropertyChanged(); } }
        private string _Phone;
        public string Phone { get => _Phone; set { _Phone = value; OnPropertyChanged(); } }
        private System.DateTime _Birthday;
        public System.DateTime Birthday { get => _Birthday; set { _Birthday = value; OnPropertyChanged(); } }
        public ObservableCollection<User> ListNhanVien { get => _ListNhanVien; set { _ListNhanVien = value;OnPropertyChanged(); } }
        public ObservableCollection<Search_NhanVien_Result> ListSearch { get => _ListSearch; set { _ListSearch = value; OnPropertyChanged(); } }
        public ObservableCollection<Search_NhanVien_Result> ListSearch2 { get => _ListSearch2; set { _ListSearch2 = value; OnPropertyChanged(); } }
        public ObservableCollection<Search_NhanVien_Result> ListSearch3 { get => _ListSearch3; set { _ListSearch3 = value; OnPropertyChanged(); } }
        public ObservableCollection<Search_Item1_Result> ListSearchItem { get => _ListSearchItem; set { _ListSearchItem = value; OnPropertyChanged(); } }
        public ObservableCollection<OrderDetailTemp> ListOrderTemp { get => _ListOrderTemp; set { _ListOrderTemp = value; OnPropertyChanged(); } }
        public ObservableCollection<Search_Combo_Result> ListSearchCombo { get => _ListSearchCombo; set { _ListSearchCombo = value; OnPropertyChanged(); } }
        public ObservableCollection<OrderDetailComboTemp> ListComboTemp { get => _ListComboTemp; set { _ListComboTemp = value; OnPropertyChanged(); } }
        public ObservableCollection<ThongKeTheoDonHang_Result> ListThongKeDonHang { get => _ListThongKeDonHang; set { _ListThongKeDonHang = value; OnPropertyChanged(); } }
        public ObservableCollection<ThongKeTheoKhachHang_Result> ListThongKeKhachHang { get => _ListThongKeKhachHang; set { _ListThongKeKhachHang = value; OnPropertyChanged(); } }
        public ObservableCollection<Search_Customer_Result> ListSearchCustomer { get => _ListSearchCustomer; set { _ListSearchCustomer = value; OnPropertyChanged(); } }

        private string _Password;
        public string Password { get => _Password; set { _Password = value; OnPropertyChanged(); } }


        //public ICommand LoadedWindowCommand { get; set; }
        #region commands
        public ICommand AddPasswordCommand { get; set; }
        public ICommand LoadedWindowCommand { get; set; }
        public ICommand CloseWindowCommand { get; set; }
        public ICommand MaximizeWindowCommand { get; set; }
        public ICommand MinimizeWindowCommand { get; set; }
        public ICommand MouseMoveWindowCommand { get; set; }
        public ICommand EditCommand { get; set; }
        public ICommand SearchCommand { get; set; }
        public ICommand SearchNhanVienCommand { get; set; }
        public ICommand SearchItemCommand { get; set; }
        public ICommand EditNhanVienCommand { get; set; }
        public ICommand AddCommand { get; set; }
        public ICommand DeleteCommand { get; set; }
        public ICommand AddNhanVienCommand { get; set; }
        public ICommand DeleteNhanVienCommand { get; set; }
        public ICommand NhapDonHangCommand { get; set; }
        public ICommand AddItemCommand { get; set; }
        public ICommand NextComboCommand { get; set; }
        public ICommand SearchComboCommand { get; set; }
        public ICommand AddComboCommand { get; set; }
        public ICommand NextCustomerCommand { get; set; }
        public ICommand FinishOrderCommand { get; set; }
        public ICommand ThongKeThucDonCommand { get; set; }
        public ICommand ThongKeKhachHangCommand { get; set; }
        public ICommand OldCustomerCommand { get; set; }
        public ICommand SearchCustomerCommand { get; set; }
        public ICommand AddOldCustomerCommand { get; set; }
        public ICommand LogoutCommand { get; set; }
        #endregion
        // mọi thứ xử lý sẽ nằm trong này
        public MainViewModel()
        {
            
            LoadedWindowCommand = new RelayCommand<Window>((p) => { return true; }, (p) =>
            {
                Isloaded = true;
                if (p == null) return;
                p.Hide();
                Login(p);
            }
            );
            CloseWindowCommand = new RelayCommand<UserControl>((p) => { return p == null ? false : true; }, (p) => {
                FrameworkElement window = GetWindowParent(p);
                var w = window as Window;
                if (w != null)
                {
                    w.Close();
                }
            }
            );
            MinimizeWindowCommand = new RelayCommand<UserControl>((p) => { return p == null ? false : true; }, (p) =>
            {
                FrameworkElement window = GetWindowParent(p);
                var w = window as Window;
                if (w != null)
                {
                    if (w.WindowState != WindowState.Minimized)
                        w.WindowState = WindowState.Minimized;
                    else
                        w.WindowState = WindowState.Maximized;
                }
            }
            );
            MouseMoveWindowCommand = new RelayCommand<UserControl>((p) => { return p == null ? false : true; }, (p) =>
            {
                FrameworkElement window = GetWindowParent(p);
                var w = window as Window;
                if (w != null)
                {
                    w.DragMove();
                }
            }
           );
            // MessageBox.Show(DataProvider.Ins.DB.Users.First().DisplayName);
            EditCommand = new RelayCommand<object>((p) => { return true;}, (p) => {
               
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                window.displaySearch.Visibility = Visibility.Collapsed;
                window.displayAddNhanVien.Visibility = Visibility.Collapsed;
                window.displayDelete.Visibility = Visibility.Collapsed;
                window.displayNhap.Visibility = Visibility.Collapsed;
                window.displayThongKeKhachHang.Visibility = Visibility.Collapsed;
                window.displayThongKeThucDon.Visibility = Visibility.Collapsed;
                window.displayEdit.Visibility = Visibility.Visible; 
            });
            SearchCommand = new RelayCommand<object>((p) => { return true; }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                window.displayEdit.Visibility = Visibility.Collapsed;
                window.displayAddNhanVien.Visibility = Visibility.Collapsed;
                window.displayDelete.Visibility = Visibility.Collapsed;
                window.displayNhap.Visibility = Visibility.Collapsed;
                window.displayThongKeKhachHang.Visibility = Visibility.Collapsed;
                window.displayThongKeThucDon.Visibility = Visibility.Collapsed;
                window.displaySearch.Visibility = Visibility.Visible;
                ListSearch = new ObservableCollection<Search_NhanVien_Result>(DataProvider.Ins.DB.Search_NhanVien("").ToList());
            });
            AddCommand = new RelayCommand<object>((p) => { return true; }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                window.displaySearch.Visibility = Visibility.Collapsed;
                window.displayEdit.Visibility = Visibility.Collapsed;
                window.displayDelete.Visibility = Visibility.Collapsed;
                window.displayThongKeKhachHang.Visibility = Visibility.Collapsed;
                window.displayThongKeThucDon.Visibility = Visibility.Collapsed;
                window.displayNhap.Visibility = Visibility.Collapsed;
                window.displayAddNhanVien.Visibility = Visibility.Visible;
            });
            SearchNhanVienCommand = new RelayCommand<object>((p) => { return true; }, (p) => {
                SearchNhanVien();
            });
            SearchItemCommand = new RelayCommand<object>((p) => { return true; }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                ListSearchItem = new ObservableCollection<Search_Item1_Result>(DataProvider.Ins.DB.Search_Item1(window.txbItem.Text).ToList());
            });
            SearchComboCommand = new RelayCommand<object>((p) => { return true; }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                ListSearchCombo = new ObservableCollection<Search_Combo_Result>(DataProvider.Ins.DB.Search_Combo(window.txbCombo.Text).ToList());
            });
            DeleteCommand = new RelayCommand<object>((p) => { return true; }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                window.displaySearch.Visibility = Visibility.Collapsed;
                window.displayEdit.Visibility = Visibility.Collapsed;
                window.displayAddNhanVien.Visibility = Visibility.Collapsed;
                window.displayThongKeKhachHang.Visibility = Visibility.Collapsed;
                window.displayThongKeThucDon.Visibility = Visibility.Collapsed;
                window.displayNhap.Visibility = Visibility.Collapsed;
                window.displayDelete.Visibility = Visibility.Visible;
            });

            EditNhanVienCommand = new RelayCommand<object>((p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                if (string.IsNullOrEmpty(window.txbEditName.Text)||string.IsNullOrEmpty(window.txbEditPhone.Text)||string.IsNullOrEmpty(window.EditBirthday.ToString()))
                    return false;
                return true;
            }, (p) =>
            {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                
                DataProvider.Ins.DB.EditUser(Convert.ToInt32(window.txbId.Text), window.txbEditName.Text, window.txbEditPhone.Text, window.EditBirthday.SelectedDate);
                SearchNhanVien();
            });
            AddPasswordCommand = new RelayCommand<PasswordBox>((p) => { return true; }, (p) => { Password = p.Password; });
            AddNhanVienCommand = new RelayCommand<object>((p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                if (string.IsNullOrEmpty(window.txbAddName.Text) || string.IsNullOrEmpty(window.txbAddAccount.Text) || string.IsNullOrEmpty(window.AddBirthday.Text) || string.IsNullOrEmpty(window.txbPhone.Text) || string.IsNullOrEmpty(Password) )
                    return false;
                return true;
            }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                string passEncode = LoginViewModel.MD5Hash(LoginViewModel.Base64Encode(Password));
                DataProvider.Ins.DB.AddUser(window.txbAddName.Text, window.txbPhone.Text, window.AddBirthday.SelectedDate, window.txbAddAccount.Text, passEncode,window.cbAddRole.IsChecked.Value);
            });
            DeleteNhanVienCommand = new RelayCommand<object>((p) => {
                if (SelectedNhanVienDelete==null)
                    return false;
                return true;
            }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive); 
                DataProvider.Ins.DB.DeleteNhanVien(SelectedNhanVienDelete.ID.ToString());
                ListSearch3 = new ObservableCollection<Search_NhanVien_Result>(DataProvider.Ins.DB.Search_NhanVien(window.txbDelete.Text).ToList());
            });
            NhapDonHangCommand = new RelayCommand<object>((p) => { return true; }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                window.displaySearch.Visibility = Visibility.Collapsed;
                window.displayEdit.Visibility = Visibility.Collapsed;
                window.displayAddNhanVien.Visibility = Visibility.Collapsed;
                window.displayDelete.Visibility = Visibility.Collapsed;
                window.displayThongKeKhachHang.Visibility = Visibility.Collapsed;
                window.displayThongKeThucDon.Visibility = Visibility.Collapsed;
                window.displayNhap.Visibility = Visibility.Visible;
                //ListOrderTemp = new ObservableCollection<OrderDetailTemp>(DataProvider.Ins.DB.OrderDetailTemps.ToList());
                //ListComboTemp = new ObservableCollection<OrderDetailComboTemp>(DataProvider.Ins.DB.OrderDetailComboTemps.ToList());
                window.txbSoLuongItem.Clear();
                window.txbSoLuongCombo.Clear();
            });
            AddItemCommand = new RelayCommand<object>((p) => {
                if (SelectedItem == null)
                    return false;
                return true;
            }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                if (window.txbSoLuongItem.Text == "") MessageBox.Show("Vui lòng nhập số lượng");
                else
                {
                    //ListOrderTemp.Clear();
                    DataProvider.Ins.DB.Add_OrderTemp(SelectedItem.ID, SelectedItem.DisplayName, SelectedItem.Price, Convert.ToInt32(window.txbSoLuongItem.Text));
                    ListOrderTemp = new ObservableCollection<OrderDetailTemp>(DataProvider.Ins.DB.OrderDetailTemps.ToList());
                    
                }
                
            });
            NextComboCommand = new RelayCommand<object>((p) => { return true; }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                window.displayNhap.Visibility = Visibility.Collapsed;
                window.displayNhapCombo.Visibility = Visibility.Visible;
            });
            AddComboCommand = new RelayCommand<object>((p) => {
                if (SelectedCombo == null)
                    return false;
                return true;
            }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                if (window.txbSoLuongCombo.Text == "") MessageBox.Show("Vui lòng nhập số lượng");
                else
                {
                    DataProvider.Ins.DB.Add_OrderComboTemp(SelectedCombo.ID, SelectedCombo.DisplayName, SelectedCombo.Price, Convert.ToInt32(window.txbSoLuongCombo.Text));
                    ListComboTemp = new ObservableCollection<OrderDetailComboTemp>(DataProvider.Ins.DB.OrderDetailComboTemps.ToList());
                }
                
            });
            NextCustomerCommand = new RelayCommand<object>((p) => { return true; }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                window.displayNhapCombo.Visibility = Visibility.Collapsed;
                window.displayCustomerInfo.Visibility = Visibility.Visible;
            });
            FinishOrderCommand = new RelayCommand<object>((p) => { return true; }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                DataProvider.Ins.DB.Add_Customer(window.txbCustomerName.Text, window.txbCustomerAddress.Text, window.txbCustomerPhone.Text, window.BirthdayCustomer.SelectedDate);
                DBCustomer LastCustomer = DataProvider.Ins.DB.DBCustomers.ToList().Last();
                DataProvider.Ins.DB.InsertOrderDetail(LastCustomer.ID, LastCustomer.Address);
                window.displayCustomerInfo.Visibility = Visibility.Collapsed;
                ListOrderTemp.Clear();
                ListComboTemp.Clear();
                //window.displayNhap.Visibility = Visibility.Visible;
            });
            ThongKeThucDonCommand = new RelayCommand<object>((p) => { return true; }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                window.displaySearch.Visibility = Visibility.Collapsed;
                window.displayEdit.Visibility = Visibility.Collapsed;
                window.displayAddNhanVien.Visibility = Visibility.Collapsed;
                window.displayDelete.Visibility = Visibility.Collapsed;
                window.displayNhap.Visibility = Visibility.Collapsed;
                window.displayThongKeKhachHang.Visibility = Visibility.Collapsed;
                window.displayThongKeThucDon.Visibility = Visibility.Visible;
                ListThongKeDonHang = new ObservableCollection<ThongKeTheoDonHang_Result>(DataProvider.Ins.DB.ThongKeTheoDonHang().ToList());
            });
            ThongKeKhachHangCommand = new RelayCommand<object>((p) => { return true; }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                window.displaySearch.Visibility = Visibility.Collapsed;
                window.displayEdit.Visibility = Visibility.Collapsed;
                window.displayAddNhanVien.Visibility = Visibility.Collapsed;
                window.displayDelete.Visibility = Visibility.Collapsed;
                window.displayNhap.Visibility = Visibility.Collapsed;
                window.displayThongKeThucDon.Visibility = Visibility.Collapsed;
                window.displayThongKeKhachHang.Visibility = Visibility.Visible;
                ListThongKeKhachHang = new ObservableCollection<ThongKeTheoKhachHang_Result>(DataProvider.Ins.DB.ThongKeTheoKhachHang().ToList());
            });
            OldCustomerCommand = new RelayCommand<object>((p) => { return true; }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                window.displayCustomerInfo.Visibility = Visibility.Collapsed;
                window.displayOldCustomer.Visibility = Visibility.Visible;
            });
            SearchCustomerCommand = new RelayCommand<object>((p) => { return true; }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                ListSearchCustomer = new ObservableCollection<Search_Customer_Result>(DataProvider.Ins.DB.Search_Customer(window.txbsearchCustomer.Text));
            });
            AddOldCustomerCommand = new RelayCommand<object>((p) => { return true; }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                DataProvider.Ins.DB.InsertOrderDetail(SelectedCustomer.ID, SelectedCustomer.Address);
                window.displayOldCustomer.Visibility = Visibility.Collapsed;
                ListOrderTemp.Clear();
                ListComboTemp.Clear();
            });
            LogoutCommand = new RelayCommand<object>((p) => { return true; }, (p) => {
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                LoginWindow lg = new LoginWindow();
                
                window.Close();
                
                MainWindow wd = new MainWindow();
                lg.ShowDialog();
                
                wd.Hide();
                if (lg.DataContext == null) return;
                var loginVM = lg.DataContext as LoginViewModel;
                if (loginVM.IsLogin)
                {
                    wd.Show();
                    MainWindow window1 = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                    if (LoginViewModel.CurrentUser.Managers == false)
                    {
                        window1.MenuNhanvien.Visibility = Visibility.Collapsed;
                        window1.MenuThongke.Visibility = Visibility.Collapsed;
                    }

                }
                else
                {
                    wd.Close();
                }


            });
        }
        void Login(Window win)
        {
            LoginWindow loginWindow = new LoginWindow();
            loginWindow.ShowDialog();
            if (loginWindow.DataContext == null) return;
            var loginVM = loginWindow.DataContext as LoginViewModel;
            if (loginVM.IsLogin)
            {
                win.Show();
                MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
                if (LoginViewModel.CurrentUser.Managers == false)
                {
                    window.MenuNhanvien.Visibility = Visibility.Collapsed;
                    window.MenuThongke.Visibility = Visibility.Collapsed;
                }

            }
            else
            {
                win.Close();
            }
        }
        

        FrameworkElement GetWindowParent(UserControl p)
        {
            FrameworkElement parent = p;

            while (parent.Parent != null)
            {
                parent = parent.Parent as FrameworkElement;
            }

            return parent;
        }
        
        void SearchNhanVien()
        {
            MainWindow window = Application.Current.Windows.OfType<MainWindow>().SingleOrDefault(w => w.IsActive);
            if (window.displaySearch.Visibility == Visibility.Visible)
            {
                ListSearch = new ObservableCollection<Search_NhanVien_Result>(DataProvider.Ins.DB.Search_NhanVien(window.txbName.Text).ToList());
            }
            if (window.displayEdit.Visibility == Visibility.Visible)
            {
                ListSearch2 = new ObservableCollection<Search_NhanVien_Result>(DataProvider.Ins.DB.Search_NhanVien(window.tbSearchNV.Text).ToList());
            }
            if (window.displayDelete.Visibility == Visibility.Visible)
            {
                ListSearch3 = new ObservableCollection<Search_NhanVien_Result>(DataProvider.Ins.DB.Search_NhanVien(window.txbDelete.Text).ToList());
            }
            
        }

        

    }
}
