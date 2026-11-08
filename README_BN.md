# Noor Islamic Calendar

**অ্যাপ নির্মাতার ক্রেডিট: মাসুম**

এই ZIP-টি Codemagic-এ আপলোড করার জন্য সাজানো। ZIP extract করলে `pubspec.yaml`, `lib/`, `android/` এবং `codemagic.yaml` একই root-এ থাকবে।

## Codemagic
Workflow `noor-android-debug` প্রথমে Flutter দিয়ে Android platform folder নতুন করে তৈরি করে, তারপর debug APK build করে। এটি পরীক্ষামূলক ইনস্টলযোগ্য APK; Play Store release-এর signed build নয়।

## সীমাবদ্ধতা
এটি UI starter prototype। বাস্তব নামাজের সময়, হিজরি ক্যালেন্ডার/ছুটি, আজান অ্যালার্ম, কিবলা, রমজান এবং offline data এখনো পূর্ণভাবে বাস্তবায়িত হয়নি। স্ক্রিনে `--:--` placeholder দেখানো হয়। নামাজের সময় যাচাই ছাড়া ব্যবহার করবেন না।
