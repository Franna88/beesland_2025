import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer_widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            _buildHeader(context),
            _buildStorySection(context),
            _buildTeamSection(context),
            _buildValuesSection(context),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 60,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xFFF8F8F8)],
        ),
      ),
      child: FadeInDown(
        duration: const Duration(milliseconds: 800),
        child: Column(
          children: [
            Text(
              'Our Story',
              style: GoogleFonts.roboto(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'From humble beginnings to becoming Jeffreys Bay\'s favourite slaghuis',
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStorySection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 80,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1000) {
            return Row(
              children: [
                Expanded(
                  flex: 6,
                  child: _buildStoryContent(),
                ),
                const SizedBox(width: 48),
                Expanded(
                  flex: 4,
                  child: FadeInRight(
                    duration: const Duration(milliseconds: 1200),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1560781290-7dc94c0f8f4f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
                        fit: BoxFit.cover,
                        height: 400,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                _buildStoryContent(),
                const SizedBox(height: 32),
                FadeInUp(
                  duration: const Duration(milliseconds: 1200),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1560781290-7dc94c0f8f4f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
                      fit: BoxFit.cover,
                      height: 300,
                      width: double.infinity,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildStoryContent() {
    return FadeInLeft(
      duration: const Duration(milliseconds: 1000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Geskiedenis',
            style: GoogleFonts.roboto(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF4D4D4D),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Sedert 1999 lewer Beesland Slaghuis top gehalte vleisprodukte. Die eerste Beesland Slaghuis het sy deure geopen in Vryburg Noordwes. Jeffreysbaai Beesland het sy deure in Maart 2012 geopen.',
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: const Color(0xFF4D4D4D),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Die eienaars, Pieter en Tertia Geyer is albei oorspronklik vanaf die Oos Kaap. Met die sluiting van Jarinda Slaghuis, het Pieter en Tertia die geleentheid gesien om die bekende Jarinda onder \'n nuwe naam, nl. Beesland Jeffreysbaai te open.',
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: const Color(0xFF4D4D4D),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Onder aanvoering van Dawie Horak het Beesland Jeffreys Baai se personeel \'n reputasie onder "locals" dat hulle die vriendelikste en hulpvaardigste diens bied aan kliënte.',
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: const Color(0xFF4D4D4D),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 80,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F8F8),
      ),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'Meet the Team',
              style: GoogleFonts.roboto(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          FadeInUp(
            duration: const Duration(milliseconds: 1000),
            child: Text(
              'The lekker okes behind the best vleis in town',
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTeamMember(
                      'Pieter Geyer',
                      'Owner & Butcher',
                      'The main oke behind the magic. Pieter knows his vleis like nobody else!',
                      0,
                    ),
                    const SizedBox(width: 32),
                    _buildTeamMember(
                      'Dawie Horak',
                      'Manager',
                      'The tjommie who keeps everything running smooth as butter.',
                      1,
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildTeamMember(
                      'Pieter Geyer',
                      'Owner & Butcher',
                      'The main oke behind the magic. Pieter knows his vleis like nobody else!',
                      0,
                    ),
                    const SizedBox(height: 32),
                    _buildTeamMember(
                      'Dawie Horak',
                      'Manager',
                      'The tjommie who keeps everything running smooth as butter.',
                      1,
                    ),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 32),
          FadeInUp(
            duration: const Duration(milliseconds: 1400),
            child: Text(
              'Die personeel sluit onder ander in: Marlou, Willie, Shupi, Gerald, Anja, Ayanda, Archi, Gloria, Patricia en Eric.',
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: const Color(0xFF4D4D4D),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(String name, String role, String description, int index) {
    return FadeInUp(
      duration: Duration(milliseconds: 1200 + (index * 200)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4D4D4D),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  name,
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF4D4D4D),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  role,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4D4D4D),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: const Color(0xFF4D4D4D),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildValuesSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : (MediaQuery.of(context).size.width > 800 ? 48 : 16),
        vertical: 80,
      ),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'What Makes Us Lekker',
              style: GoogleFonts.roboto(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF4D4D4D),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 1000) {
                return Row(
                  children: [
                    Expanded(child: _buildValueCard(0)),
                    const SizedBox(width: 24),
                    Expanded(child: _buildValueCard(1)),
                    const SizedBox(width: 24),
                    Expanded(child: _buildValueCard(2)),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildValueCard(0),
                    const SizedBox(height: 24),
                    _buildValueCard(1),
                    const SizedBox(height: 24),
                    _buildValueCard(2),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard(int index) {
    final values = [
      {
        'icon': Icons.star,
        'title': '100% A Graad Steaks',
        'description': 'Wors en maalvleis sonder volksveemde bestanddele of vermengings.',
      },
      {
        'icon': Icons.favorite,
        'title': 'Persoonlike Diens',
        'description': 'Ons kliënte word ons vriende, en daarom is u verseker van persoonlike, vriendelike en hulpvaardige diens.',
      },
      {
        'icon': Icons.thumb_up,
        'title': 'Die Beste Kwaliteit',
        'description': 'Dit is ons trots en passie om die beste kwaliteit vleisprodukte aan ons kliënte beskikbaar te stel.',
      },
    ];

    return FadeInUp(
      duration: Duration(milliseconds: 1000 + (index * 200)),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4D4D4D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  values[index]['icon'] as IconData,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                values[index]['title'] as String,
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF4D4D4D),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                values[index]['description'] as String,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: const Color(0xFF4D4D4D),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 