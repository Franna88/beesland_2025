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
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        image: DecorationImage(
          image: const AssetImage('images/meat_items/wors.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.7),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'OUR STORY',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 4,
                color: Colors.white70,
              ),
            ),
          ),
          const SizedBox(height: 24),
          FadeInDown(
            duration: const Duration(milliseconds: 1000),
            child: Text(
              'A Legacy of Excellence',
              style: GoogleFonts.playfairDisplay(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          FadeInDown(
            duration: const Duration(milliseconds: 1200),
            child: Text(
              'Since 1999',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Colors.white70,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorySection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1000) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth > 1200 ? 80 : 24,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: _buildStoryContent(),
                  ),
                  const SizedBox(width: 60),
                  Expanded(
                    flex: 4,
                    child: FadeInRight(
                      duration: const Duration(milliseconds: 1200),
                      child: Container(
                        height: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 10),
                              blurRadius: 20,
                            ),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('images/beesland_logo.jpg'),
                            fit: BoxFit.contain,
                          ),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildStoryContent(),
                  const SizedBox(height: 40),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1200),
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0, 10),
                            blurRadius: 20,
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage('images/beesland_logo.jpg'),
                          fit: BoxFit.contain,
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
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
            'GESKIEDENIS',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 4,
              color: const Color(0xFF2C2C2C),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Our Journey',
            style: GoogleFonts.playfairDisplay(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C2C2C),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Sedert 1999 lewer Beesland Slaghuis top gehalte vleisprodukte. Die eerste Beesland Slaghuis het sy deure geopen in Vryburg Noordwes. Jeffreysbaai Beesland het sy deure in Maart 2012 geopen.',
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: const Color(0xFF4D4D4D),
              height: 1.8,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Die eienaars, Pieter en Tertia Geyer is albei oorspronklik vanaf die Oos Kaap. Met die sluiting van Jarinda Slaghuis, het Pieter en Tertia die geleentheid gesien om die bekende Jarinda onder \'n nuwe naam, nl. Beesland Jeffreysbaai te open.',
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: const Color(0xFF4D4D4D),
              height: 1.8,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Onder aanvoering van Dawie Horak het Beesland Jeffreys Baai se personeel \'n reputasie onder "locals" dat hulle die vriendelikste en hulpvaardigste diens bied aan kliënte.',
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: const Color(0xFF4D4D4D),
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        image: DecorationImage(
          image: const AssetImage('images/meat_items/beef-mince.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.85),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : 24,
            ),
            child: Column(
              children: [
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    'OUR TEAM',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 4,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: Text(
                    'Meet the Experts',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  duration: const Duration(milliseconds: 1200),
                  child: Text(
                    'The passionate team behind your favorite butchery',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                _buildTeamPhotosGrid(context),
                const SizedBox(height: 60),
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
                const SizedBox(height: 40),
                FadeInUp(
                  duration: const Duration(milliseconds: 1400),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Die personeel sluit onder ander in: Marlou, Willie, Shupi, Gerald, Anja, Ayanda, Archi, Gloria, Patricia en Eric.',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamPhotosGrid(BuildContext context) {
    final teamPhotos = [
      'images/team/team1.jpg',
      'images/team/team2.jpg',
      'images/team/team3.jpg',
      'images/team/team4.jpg',
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= 800;
        final photoSize = isMobile ? constraints.maxWidth : (constraints.maxWidth - 90) / 4;
        final photoHeight = photoSize * 1.2;

        return Wrap(
          spacing: 30,
          runSpacing: 30,
          alignment: WrapAlignment.center,
          children: teamPhotos.asMap().entries.map((entry) {
            final index = entry.key;
            final photo = entry.value;
            return FadeInUp(
              duration: Duration(milliseconds: 1200 + (index * 200)),
              child: Container(
                width: photoSize,
                height: photoHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 10),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        photo,
                        width: photoSize,
                        height: photoHeight,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.6),
                          ],
                          stops: const [0.6, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildTeamMember(String name, String role, String description, int index) {
    return FadeInUp(
      duration: Duration(milliseconds: 1200 + (index * 200)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.person,
                color: Colors.white.withOpacity(0.9),
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              name,
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              role,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Colors.white70,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValuesSection(BuildContext context) {
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

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width > 1200 ? 80 : 24,
            ),
            child: Column(
              children: [
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    'OUR VALUES',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 4,
                      color: const Color(0xFF2C2C2C),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: Text(
                    'What Makes Us Different',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C2C2C),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 1000) {
                      return Row(
                        children: values.asMap().entries.map((entry) {
                          final index = entry.key;
                          final value = entry.value;
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? 0 : 15,
                                right: index == values.length - 1 ? 0 : 15,
                              ),
                              child: _buildValueCard(value, index),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return Column(
                        children: values.asMap().entries.map((entry) {
                          final index = entry.key;
                          final value = entry.value;
                          return Padding(
                            padding: EdgeInsets.only(bottom: index == values.length - 1 ? 0 : 30),
                            child: _buildValueCard(value, index),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard(Map<String, dynamic> value, int index) {
    return FadeInUp(
      duration: Duration(milliseconds: 1000 + (index * 200)),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 10),
              blurRadius: 20,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                value['icon'] as IconData,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              value['title'] as String,
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2C2C2C),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              value['description'] as String,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: const Color(0xFF4D4D4D),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
} 