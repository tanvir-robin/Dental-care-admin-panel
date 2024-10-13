import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_care_admin/doctors/available_doctors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> appointments = [];
  List<Map<String, dynamic>> transactions = [];
  List<Map<String, dynamic>> users = [];

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();
    _fetchAppointments();
    _fetchTransactions();
    _fetchUsers();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchAppointments() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('appointments').get();

      setState(() {
        appointments = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print('Error fetching appointments: $e');
    }
  }

  Future<void> _fetchTransactions() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('transactions').get();

      setState(() {
        transactions = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

  Future<void> _fetchUsers() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();

      setState(() {
        users = snapshot.docs.map((doc) {
          Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
          userData['id'] = doc.id; // Adding document ID
          return userData;
        }).toList();
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  String getPatientName(String patientDocID) {
    final user = users.firstWhere((user) => user['id'] == patientDocID,
        orElse: () => {});
    return user.isNotEmpty ? user['username'] : 'Unknown Patient';
  }

  String getDoctorName(int doctorId) {
    final doctor = demoAvailableDoctors.firstWhere((doc) => doc.id == doctorId,
        orElse: () => AvailableDoctor(
            id: 0,
            name: 'Unknown Doctor',
            sector: '',
            experience: 0,
            patients: '0',
            image: '',
            email: '',
            password: ''));
    return doctor.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dental Care Admin Dashboard"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[300]!, Colors.lightBlue[200]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: FadeTransition(
              opacity: _controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummarySection(),
                  SizedBox(height: 20),
                  _buildSectionTitle("Available Doctors"),
                  _buildDoctorList(),
                  SizedBox(height: 20),
                  _buildSectionTitle("Appointments"),
                  _buildAppointmentList(),
                  SizedBox(height: 20),
                  _buildSectionTitle("Transactions"),
                  _buildTransactionList(),
                  SizedBox(height: 20),
                  _buildSectionTitle("Patients Registered"),
                  _buildUserList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSummarySection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSummaryCard("Total Users", users.length.toString()),
        _buildSummaryCard("Appointments", appointments.length.toString()),
        _buildSummaryCard(
            "Total Transactions", "BDT " + _getTotalTransactionAmount()),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value) {
    return Expanded(
      child: Card(
        elevation: 10,
        shadowColor: Colors.teal.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white.withOpacity(0.9), // Summary card color
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 10),
              Text(value, style: TextStyle(fontSize: 26, color: Colors.teal)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorList() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: demoAvailableDoctors.length,
        itemBuilder: (context, index) {
          return _buildDoctorCard(demoAvailableDoctors[index]);
        },
      ),
    );
  }

  Widget _buildDoctorCard(AvailableDoctor doctor) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        width: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(doctor.image,
                  height: 80, width: 80, fit: BoxFit.cover),
            ),
            SizedBox(height: 8),
            Text(doctor.name,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
                textAlign: TextAlign.center),
            Text(doctor.sector,
                style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey),
                textAlign: TextAlign.center),
            Text("${doctor.experience} years",
                style: TextStyle(fontSize: 12, color: Colors.teal),
                textAlign: TextAlign.center),
            Text("${doctor.patients} patients",
                style: TextStyle(fontSize: 12, color: Colors.teal),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            title: Text("Doctor: ${getDoctorName(appointment['doctorId'])}",
                style: TextStyle(color: Colors.teal)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Patient: ${getPatientName(appointment['patientDocID'])}",
                    style: TextStyle(color: Colors.grey)),
                Text("Complaint: ${(appointment['complaint'])}",
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
            trailing:
                Text(formatDateTime(appointment['dateTime'] as Timestamp)),
          ),
        );
      },
    );
  }

  Widget _buildTransactionList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              title: Text("Trx ID: ${transaction['tran_id']}",
                  style: TextStyle(color: Colors.teal)),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Amount: ${transaction['amount']} BDT",
                      style: TextStyle(color: Colors.grey)),
                  Text("${transaction['card_type']}",
                      style: TextStyle(color: Colors.grey)),
                  Text("User: ${getPatientName(transaction['user'])}",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
              trailing: transaction['status'] == 'VALID'
                  ? Icon(Icons.done_outline_rounded)
                  : Icon(Icons.cancel),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              title:
                  Text(user['username'], style: TextStyle(color: Colors.teal)),
              subtitle: Text(user['email'] ?? 'No Email',
                  style: TextStyle(color: Colors.grey)),
            ),
          );
        },
      ),
    );
  }

  String formatDateTime(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    return DateFormat('dd MMM, hh:mm a').format(dateTime);
  }

  String _getTotalTransactionAmount() {
    double total = transactions.fold(0, (sum, transaction) {
      return sum + (double.tryParse(transaction['amount']) ?? 0);
    });
    return total.toStringAsFixed(2);
  }
}
