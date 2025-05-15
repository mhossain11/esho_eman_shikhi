import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  final String phoneNumber= '01687477579';
  final String fbUrl = 'https://www.facebook.com/faysal11hossain';
  final String fbGroupUrl = 'https://www.facebook.com/liberalsoft';
  final String linkedinUrl = 'https://www.linkedin.com/in/syed-faysal-hossain-885826196';
  final String whatsappUrl = 'https://www.facebook.com/yourPageOrProfile';
  final String profileUrl = 'https://www.faysalhossain.com/';
  final String webSiteUrl = 'https://liberalsoft.net/';


  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
      webViewConfiguration: WebViewConfiguration(enableJavaScript: true),
    )) {
      throw 'Could not launch $urlString';
    }
  }


  Future<void> _launchDialer(String number) async {
    final Uri url = Uri.parse('tel:$number');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Card(
            elevation: 5,
            shadowColor: Colors.grey,
            child: Center(
              child: Container(
                width: size.width * 0.9,
                height: 550,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('আসসালামু আলাইকুম সম্মানিত পাঠক পাঠিকা আমি এই অ্যাপটি আপনাদের সেবাই তৈরি করেছি, আমি আপ্রাণ চেষ্টা করেছি নিরবিচ্ছিন্ন সেবা দিতে,তারপরও যদি কোন সমস্যা আপনাদের চোখে পড়ে প্লিজ আমাকে জানাবেন আমি সমাধান করবো।',
                        textAlign: TextAlign.justify,style: TextStyle(fontSize: 16),),
                      Center(child: Text('ইনশাআল্লাহ।',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
                      SizedBox(height: 30,),
                      ElevatedButton(
                          onPressed: (){
                            _launchUrl(fbGroupUrl);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // ✅ background color change
                            foregroundColor: Colors.grey,
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),


                          child: Text('Our Office Facebook Group',style: TextStyle(color: Colors.black),)),
                      SizedBox(height: 20,),
                      ElevatedButton(
                          onPressed: (){
                            _launchUrl(webSiteUrl);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // ✅ background color change
                            foregroundColor: Colors.grey,
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),


                          child: Text('Our Office Website',style: TextStyle(color: Colors.black),)),
                      SizedBox(height: 20,),
                      ElevatedButton(
                          onPressed: (){
                            _launchDialer(phoneNumber);
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey,
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),

                          child: Text('Contact',style: TextStyle(color: Colors.black))),
                      SizedBox(height: 40,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              _launchUrl(fbUrl);
                              print('Facebbok');
                            },
                            child: Image.asset('assets/icon/facebook.png',width: 50,height: 45,),),
                          SizedBox(width: 10,),
                          GestureDetector(
                              onTap: (){
                                _launchUrl(linkedinUrl);
                              },
                              child: Image.asset('assets/icon/linkedin.png',width: 50,height: 45,)),
                          SizedBox(width: 10,),
                          GestureDetector(
                              onTap: (){
                                _launchUrl(profileUrl);
                              },
                              child: Image.asset('assets/icon/resume.png',width: 50,height: 45,)),
                        ],
                      )

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
