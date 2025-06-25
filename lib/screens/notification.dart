import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF396148),
            size: 24,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: Colors.blue,
              indicatorWeight: 3,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Toutes', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('5', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Alertes', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('3', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Non lues', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('2', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAllNotifications(),
          _buildAlerts(),
          _buildUnreadNotifications(),
        ],
      ),
    );
  }

  Widget _buildAllNotifications() {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        _buildAlertNotification(
          'Alerte',
          'Problème d\'arrosage détecté dans le secteur A',
          Icons.warning,
          Colors.red,
          true,
        ),
        _buildAlertNotification(
          'Erreur',
          'Risque de chute d\'arbre signalé sur l\'avenue principale',
          Icons.error,
          Colors.red,
          false,
        ),
        _buildAlertNotification(
          'Erreur',
          'Danger détecté autour de l\'aire de jeux',
          Icons.dangerous,
          Colors.red,
          true,
        ),
        _buildRegularNotification(
          'Salut Marie !',
          'Votre demande de maintenance a été approuvée et sera traitée dans les 48h prochaines.',
          '2h',
        ),
        _buildRegularNotification(
          'Salut Marie !',
          'Rappel: Réunion d\'équipe prévue demain à 14h en salle de conférence.',
          '4h',
        ),
      ],
    );
  }

  Widget _buildAlerts() {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        _buildAlertNotification(
          'Alerte',
          'Problème d\'arrosage détecté dans le secteur A',
          Icons.warning,
          Colors.red,
          true,
        ),
        _buildAlertNotification(
          'Erreur',
          'Risque de chute d\'arbre signalé sur l\'avenue principale',
          Icons.error,
          Colors.red,
          false,
        ),
        _buildAlertNotification(
          'Erreur',
          'Danger détecté autour de l\'aire de jeux',
          Icons.dangerous,
          Colors.red,
          true,
        ),
      ],
    );
  }

  Widget _buildUnreadNotifications() {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        _buildAlertNotification(
          'Alerte',
          'Problème d\'arrosage détecté dans le secteur A',
          Icons.warning,
          Colors.red,
          true,
        ),
        _buildAlertNotification(
          'Erreur',
          'Danger détecté autour de l\'aire de jeux',
          Icons.dangerous,
          Colors.red,
          true,
        ),
      ],
    );
  }

  Widget _buildAlertNotification(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    bool isUnread,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isUnread ? Colors.red[50] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnread ? Colors.red[100]! : Colors.grey[200]!,
          width: isUnread ? 2 : 1,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.3,
            ),
          ),
        ),
        trailing: isUnread
            ? Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildRegularNotification(String title, String subtitle, String time) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.3,
            ),
          ),
        ),
        trailing: Text(
          time,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }
}
