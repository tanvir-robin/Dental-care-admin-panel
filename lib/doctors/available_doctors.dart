class AvailableDoctor {
  final int id;
  final String name;
  final String sector;
  final int experience;
  final String patients;
  final String image;
  final String email;
  final String password;

  AvailableDoctor({
    required this.id,
    required this.name,
    required this.sector,
    required this.experience,
    required this.patients,
    required this.image,
    required this.email,
    required this.password,
  });
}

List<AvailableDoctor> demoAvailableDoctors = [
  AvailableDoctor(
    id: 1,
    name: "Dr. Serena Gome",
    sector: "Medicine Specialist",
    experience: 8,
    patients: '1.08K',
    image: "assets/images/Serena_Gome.png",
    email: "serena.gome@example.com",
    password: "password1",
  ),
  AvailableDoctor(
    id: 2,
    name: "Dr. Asma Khan",
    sector: "Medicine Specialist",
    experience: 5,
    patients: '2.7K',
    image: "assets/images/Asma_Khan.png",
    email: "asma.khan@example.com",
    password: "password2",
  ),
  AvailableDoctor(
    id: 3,
    name: "Dr. Kiran Shakia",
    sector: "Medicine Specialist",
    experience: 5,
    patients: '2.7K',
    image: "assets/images/Kiran_Shakia.png",
    email: "kiran.shakia@example.com",
    password: "password3",
  ),
  AvailableDoctor(
    id: 4,
    name: "Dr. Masuda Khan",
    sector: "Medicine Specialist",
    experience: 5,
    patients: '2.7K',
    image: "assets/images/Masuda_Khan.png",
    email: "masuda.khan@example.com",
    password: "password4",
  ),
  AvailableDoctor(
    id: 5,
    name: "Dr. Johir Raihan",
    sector: "Medicine Specialist",
    experience: 5,
    patients: '2.7K',
    image: "assets/images/Johir_Raihan.png",
    email: "johir.raihan@example.com",
    password: "password5",
  ),
];
