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
    name: "Dr. Md. Imran Hossain",
    sector: "Orthodontist",
    experience: 8,
    patients: '1.08K',
    image: "assets/images/doc1.png",
    email: "doc1@gmail.com",
    password: "password1",
  ),
  AvailableDoctor(
    id: 2,
    name: "Prof. Dr. B.A.K Azad",
    sector: "OMS",
    experience: 5,
    patients: '2.7K',
    image: "assets/images/doc2.png",
    email: "doc2@gmail.com",
    password: "password2",
  ),
  AvailableDoctor(
    id: 3,
    name: "Dr. Proshenjit Sarker",
    sector: "OMS, Endodontist",
    experience: 5,
    patients: '2.7K',
    image: "assets/images/doc3.png",
    email: "doc3@gmail.comm",
    password: "password3",
  ),
  AvailableDoctor(
    id: 4,
    name: "Dr. Roksana Begum",
    sector: "Pedodontist, DPH",
    experience: 5,
    patients: '2.7K',
    image: "assets/images/doc4.png",
    email: "doc4@gmail.comm",
    password: "password4",
  ),
  AvailableDoctor(
    id: 5,
    name: "Dr. Farzana Anar",
    sector: "Periodontist, Orthodontist",
    experience: 5,
    patients: '2.7K',
    image: "assets/images/doc5.png",
    email: "doc5@gmail.com",
    password: "password5",
  ),
];
