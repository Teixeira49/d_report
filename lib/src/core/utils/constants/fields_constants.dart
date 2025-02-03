const double sizeRegisterBalls = 12.5;

const int totalRegisterPages = 4;

const bool obscureTextDefault = false;

const String caseDetails = "Detalles del Caso";

const String patient = "Paciente";

const String user = "Usuario";

const String nameUser = 'Name *';

const String hintNameUser = 'What do people call you?';

const String lastNameUser = 'Last Name *';

const String hintLastNameUser = 'What do people call you?';

const String hintEditProfile = 'you dont forget edit this row';

const String email = 'Email';

const String password = 'Password';

const String validatePassword = 'Repeat same Password';

const String loadData = 'Iniciar sesion';

const String registerData = 'Registrar';

const String continueRegister = 'Continuar';

const String genre = "Genero";

const String hintGenre = "Please, select a genre";

const String blood = "Tipo de Sangre";

const String hintBlood = "Porfavor, Seleccione un tipo de Sangre";

const String entryArea = "Area de Ingreso";

const String hintArea = "Porfavor diga en que area fue internado";

const String floor = "Piso";

const String birthday = 'Cumpleaños';

const String hintBirthday = "Cuando cumples";

final List<String> genreType = <String>["Male","Female","Other"];

final List<String> genreTypeFull = <String>["Hombre","Mujer","Otros", 'Todos'];

final Map<String, String> genreTypeFullMeta = {'Male':"Hombre", 'Female':"Mujer", 'Other':"Otros", '':'Todos'};

final List<String> bloodType = <String>["Rh Nulo","A+","A-","B+","B-","AB+","AB-","O+","O-",'Desconocido',"Otro"];

final List<String> entryAreaType = <String>["Emergency", "Hospitalization", "Surgery"];

final Map<String, String> entryAreaTypeMeta = {"Emergency": 'Emergencia', "Hospitalization": 'Hospitalizacion', "Surgery": 'Cirugia'};

final List<String> endCaseType = ['Recuperado', 'Murio', 'Referido', 'Retirado'];

final Map<String, String> endCaseTypeMeta = {'SURVIVE': 'Recuperado', 'DEAD': 'Murio', 'REFERRAL':'Referido', 'ESCAPED': 'Retirado'};

final List<String> endCaseTypeFull = ['Recuperado', 'Murio', 'Referido', 'Retirado', 'Activo', 'Todos']; // TODO Sobrevivio?  JAJAJJAJA

final List<String> caseStatusType = ['Activo', 'Finalizado', 'Todos'];

final List<String> addCaseFollowType = ['Ninguno', 'Solo Mios', 'Todos'];

final List<String> floorType = <String>["1","2","3","4","5","6"]; // TODO Cambiar a que la lista se genere sola

const String role = "Roles"; // TODO Crear su propio archivo de constantes

const String hintRole = 'Please, select one role';

const String point = '. ';

const String space = " ";

const String edit = "Editar Perfil";

final List<String> userType = <String>["Doctor","Resident","Administrator"]; // TODO Crear su propio archivo de constantes

final Map<String, String> translateGenreType = {
  'Male': 'Hombre',
  'Female': 'Mujer',
  'Other': 'Otro'
};

final Map<int, List<String>> checkEqualityUpdateCase = {
  0: ['casSymptomatology', 'casPhysicalState', 'casDiagnosis'],
  1: ['casActualRoom', 'casEntryArea'], //'casMethodOfEntry',
  2: ['casEndReason', 'casEndDiagnosis'],
}; // TODO DELETE StudyIMG

final Map<int, List<String>> checkEqualityUpdatePatient = {
  0: ['patFirstName', 'patSecondName', 'patLastname', 'patSecondSurname'],
  1: ['patBirthdayDate', 'patBirthdayPlace', 'patBloodType', 'patDni', 'patGender', 'patWeight', 'patHeight'], //'casMethodOfEntry',
}; // TODO DELETE StudyIMG and create other constant file