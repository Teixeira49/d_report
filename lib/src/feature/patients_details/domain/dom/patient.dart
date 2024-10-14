
class Patient{

  Patient(
    {
      required this.id,
      required this.name,
      required this.lastname,
      required this.age,
      required this.codHab
    }
  );

  int id;
  String name;
  String lastname;
  int age;
  String codHab;

  String getMessage(){
    return 'Age: $age\nHabitation: $codHab';
  }

  String getAllName(){
    return '$name $lastname';
  }

  int getAge(){
    return age;
  }
}