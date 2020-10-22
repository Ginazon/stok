class Hatalar{
  static goster(String hataKodu){
    switch(hataKodu){
      case"email-already-in-use": return"Mail adresi ile daha önce bir hesap oluşturuldu";
      case"user-not-found": return"Böyle bir hesap yok";

      default:return "Bir Hata Oluştu";

    }
  }
}