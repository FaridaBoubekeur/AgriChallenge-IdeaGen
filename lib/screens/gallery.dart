import 'package:flutter/material.dart';
import 'card.dart';

// Pour rendre cette page fonctionnelle, vous pouvez l'ajouter à votre flux de navigation.
// Par exemple, ajoutez un nouveau bouton sur votre tableau de bord qui navigue ici :
// onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GalleryScreen())),

// --- Modèle de données pour une photo ---
// L'utilisation d'une classe rend le code plus propre et plus évolutif.
class PhotoItem {
  final int id;
  final String imageUrl;
  final String title;
  final String location;
  final String date;
  final String description;

  const PhotoItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.date,
    required this.description,
  });
}

// --- Widget principal de l'écran de la galerie ---
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  // --- Données de démonstration ---
  // Utilisation d'images de picsum.photos pour la démonstration.
  final List<PhotoItem> _photoItems = const [
    PhotoItem(
      id: 1,
      imageUrl: '/assets/images/tarzan.png',
      title: 'Arbre de Tarzan',
      location: 'Ar',
      date: '15 Juin 2023',
      description:
          'Une photo capturant la lumière du matin filtrant à travers les cèdres majestueux.',
    ),
    PhotoItem(
      id: 2,
      imageUrl: '/assets/images/monument.png',
      title: 'Monument',
      location: 'Vallée de l\'Ourika',
      date: '22 Avril 2023',
      description:
          'Champ de fleurs sauvages colorées au printemps dans les montagnes de l\'Atlas.',
    ),
    PhotoItem(
      id: 3,
      imageUrl: '/assets/images/pont.png',
      title: 'Lac',
      location: 'Région de l\'Oriental',
      date: '05 Septembre 2023',
      description: 'Vue aérienne d\'une rivière traversant un paysage aride.',
    ),
    PhotoItem(
      id: 4,
      imageUrl: '/assets/images/status.png',
      title: 'Status',
      location: 'Projet de Reforestation',
      date: '30 Mars 2024',
      description:
          'Gros plan sur une jeune pousse, symbole d\'espoir pour la régénération forestière.',
    ),
    PhotoItem(
      id: 5,
      imageUrl: '/assets/images/jungle.png',
      title: 'Jungle',
      location: 'Désert d\'Agafay',
      date: '18 Novembre 2023',
      description:
          'Les couleurs chaudes du coucher de soleil sur les dunes du désert.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie de Photos'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 colonnes
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 0.8, // Ajuster le ratio pour un meilleur rendu
        ),
        itemCount: _photoItems.length,
        itemBuilder: (context, index) {
          final photo = _photoItems[index];
          // Utiliser un tag unique pour l'animation Hero
          final heroTag = 'photo-${photo.id}';

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlantDetailScreen(),
                ),
              );
            },
            child: Hero(
              tag: heroTag,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                    image: NetworkImage(photo.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                // Ajouter un dégradé pour la lisibilité du texte
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                      stops: const [0.6, 1.0],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        photo.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
