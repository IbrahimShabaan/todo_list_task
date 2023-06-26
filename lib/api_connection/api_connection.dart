
class API {
  static const hostConnect = "https://todolistflutterapptask.000webhostapp.com/todo_list/";
  static const hostConnectUser = "$hostConnect/users";
  static const hostNotes = "$hostConnect/notes";



  //sign-up - LoginUser

  static const validateEmail = "$hostConnectUser/validate_email.php";
  static const login = "$hostConnectUser/login.php";

  //upload - save newitem
  static const uploadNewNote = "$hostNotes/upload.php";

  // New Notes
  static const getAllNotes = "$hostNotes/all.php";


  static const deleteNote = "$hostNotes/delete.php";
  // static const updateItemInCartList = "$hostCart/update.php";





}