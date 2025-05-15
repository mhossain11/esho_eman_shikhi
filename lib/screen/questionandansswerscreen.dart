import 'package:flutter/material.dart';

class QuestionAndAnswerScreen extends StatelessWidget {
  const QuestionAndAnswerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('প্রশ্ন ও উত্তর'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('প্রশ্ন: এটা কি ধরনের অ্যাপ?',style: TextStyle(fontSize: 16),),
              Text('উত্তর: Offline অ্যাপ।',style: TextStyle(fontSize: 16),),
              SizedBox(height: 10,),
              Text('প্রশ্ন: এই অ্যাপ ব্যবহারকারীর কোন ডাটা নিবে?',style: TextStyle(fontSize: 16),),
              Text('উত্তর: না। এই অ্যাপ ইনেস্টল করার সময় কোন পারমিশন বা অ্যাক্সেস চাইবে না।',style: TextStyle(fontSize: 16),),
              SizedBox(height: 10,),
              Text('প্রশ্ন: এই অ্যাপে কি আছে?',style: TextStyle(fontSize: 16),),
              Text('উত্তর: এই অ্যাপ এসো ঈমান শিখি একটি বই ।',style: TextStyle(fontSize: 16),),
              SizedBox(height: 10,),
              Text('প্রশ্ন: এই বই গুলো কোথা থেকে পেয়েছেন?',style: TextStyle(fontSize: 16),),
              Text('উত্তর:  বই অনলাইন থেকে নেয়া হয়েছে।',style: TextStyle(fontSize: 16),),
              SizedBox(height: 10,),
              Text('প্রশ্ন: এই অ্যাপ কারা ব্যবহার করবে?',style: TextStyle(fontSize: 16),),
              Text('উত্তর: যারা ইসলামের সঠিক জ্ঞান এবং রেফারেন্স সহ খুজছেন তারা এই অ্যাপ ব্যবহার করবে।এই অ্যাপ সকলের জন্য।',style: TextStyle(fontSize: 16),),
              SizedBox(height: 10,),
              Text('প্রশ্ন: এই অ্যাপ কে বানিয়েছে এবং কেন?',style: TextStyle(fontSize: 16),),
              Text('উত্তর:এই অ্যাপ বানিয়েছে ডেভেলপার ফয়সাল। ইসলাম এর সত্য কথা তুলে ধরার জন্য।',style: TextStyle(fontSize: 16),),
              SizedBox(height: 10,),
              Text('প্রশ্ন: এই অ্যাপে কি বিজ্ঞাপন আসবে ?',style: TextStyle(fontSize: 16),),
              Text('উত্তর:না। এই অ্যাপ এ কোন বিজ্ঞাপন সেট করা হয় নাই।',style: TextStyle(fontSize: 16),),
              Divider(height: 24),
              Text(
                'রইসলামি জীবনাদর্শের মূল ভিত্তি আল-কুরআন এবং দ্বিতীয় ভিত্তি আল-হাদিস। কুরআন জীবন বিধানের মৌলিক নীতিমালা উপস্থাপন করে, আর হাদিস সেই মৌলনীতির আলোকে ব্যাখ্যা-বিশ্লেষণ উপস্থাপন করে। তাই হাদিস হচ্ছে কুরআনের নির্ভুল ব্যাখ্যা, কুরআনের বাহক বিশ্বনবীর হজরত মুহাম্মদ (সঃ) পবিত্র জীবনচরিত, কর্মনীতি ও আদর্শ তথা তাঁর বাণী, কাজ, হেদায়াত ও উপদেশাবলির বিস্তৃত উপস্থাপনা।ইসলামি জীবন-দর্শনে কুরআনের সাথে হাদিসের রয়েছে অপরিসীম গুরুত্ব।',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[700],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
