class Model{

  int? UserId;
  String? Nama, TanggalLahir, password, RegisterDateTime, StatusLogin,LoginDateTime , LogoutDateTime, Email,  KonfirmasiPassword, namaLengkap, alamat, nomorTelepon;

  Model({this.UserId, this.Nama, this.TanggalLahir, this.password, this.RegisterDateTime, this.StatusLogin, this. LoginDateTime, this.LogoutDateTime, this.Email, this.KonfirmasiPassword, this.namaLengkap, this.alamat, this.nomorTelepon});

  factory Model.fromJson(Map<String, dynamic> json){
    return Model(
      UserId: json['UserId'],
      Nama: json['Nama'],
      TanggalLahir: json['TanggalLahir'],
      KonfirmasiPassword: json['KonfirmasiPassword'],
      password: json['password'],
      RegisterDateTime: json['RegisterDateTime'],
      StatusLogin: json['StatusLogin'],
      LoginDateTime: json['LoginDateTime'],
      LogoutDateTime: json['LogoutDateTime'],
      Email: json['Email'],
      namaLengkap : json['namaLengkap'],
    alamat : json['alamat'],
    nomorTelepon : json['nomorTelepon']

    );
  }
}