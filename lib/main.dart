import 'package:flutter/material.dart';

void main() {
  runApp(const ShareApp());
}

class ShareApp extends StatelessWidget {
  const ShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تطبيق المشاركة',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Cairo', // يمكنك استبداله بالخط المفضل لديك
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('مشاركة الملفات والتطبيقات', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            // بطاقة المشاركة المحلية (بدون إنترنت)
            Expanded(
              child: _buildFeatureCard(
                context,
                title: 'مشاركة قريبة (بدون إنترنت)',
                subtitle: 'نقل سريع جداً عبر نقطة اتصال محلية و QR Code',
                icon: Icons.wifi_tethering,
                color: Colors.orangeAccent,
                onTap: () {
                  // هنا تكتب كود فتح شاشة الـ QR والاتصال المباشر
                  _showToast(context, 'جاري فتح نافذة المشاركة المحلية...');
                },
              ),
            ),
            const SizedBox(height: 20),
            // بطاقة المشاركة عن بُعد (برقم الهاتف)
            Expanded(
              child: _buildFeatureCard(
                context,
                title: 'مشاركة عن بُعد (برقم الهاتف)',
                subtitle: 'إرسال الملفات لأي شخص في أي مكان عبر رقمه',
                icon: Icons.phone_iphone,
                color: Colors.blueAccent,
                onTap: () {
                  // هنا تكتب كود شاشة إدخال رقم الجوال والرفع السحابي
                  _showPhoneInputDialog(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // تصميم البطاقات التفاعلية
  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(color: color.withOpacity(0.3), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, size: 35, color: color),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // نافذة منبثقة لإدخال رقم الهاتف عند اختيار الإرسال عن بُعد
  void _showPhoneInputDialog(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إرسال برقم الهاتف'),
        content: TextField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'أدخل رقم الهاتف المستهدف',
            hintText: 'مثال: 05xxxxxxxx',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showToast(context, 'جاري الاتصال بالرقم: ${phoneController.text}');
            },
            child: const Text('متابعة'),
          ),
        ],
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}
