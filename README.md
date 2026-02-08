# থানা/ইউনিয়ন গ্রুপ বাইং (MVP)

এই Flutter অ্যাপটি বাংলাদেশের জন্য থানা ভিত্তিক গ্রুপ অর্ডারিং সিস্টেমের MVP। ইউজার নির্দিষ্ট সময়ের মধ্যে অর্ডার করে, থানা ম্যানেজার বাল্ক শিপমেন্ট নিয়ে ইউনিয়নে বিতরণ করেন।

## ফিচার সমূহ
- বাংলা UI (bn-BD)
- Supabase ইন্টিগ্রেশন (Auth + DB + Storage প্রস্তুত)
- ব্যাচ উইন্ডো ও মিনিমাম অর্ডার ট্র্যাকিং
- কুরিয়ার কস্ট ক্যালকুলেশন
- কাস্টমার, ম্যানেজার ও অ্যাডমিন স্ক্রিন কাঠামো

## সেটআপ
### প্রয়োজনীয়তা
- Flutter (latest stable)
- Dart 3.3+

### 1) ডিপেন্ডেন্সি ইন্সটল
```bash
flutter pub get
```

### 2) Supabase এনভায়রনমেন্ট
প্রজেক্ট রুটে `.env` ফাইল তৈরি করুন (কমিট করবেন না):
```
SUPABASE_URL=আপনার_supabase_url
SUPABASE_ANON_KEY=আপনার_anon_key
```

**SUPABASE_URL ও ANON_KEY** পেতে:
1. Supabase Dashboard এ যান
2. Project Settings → API
3. সেখানে Project URL এবং anon public key কপি করুন

### 3) Supabase SQL মাইগ্রেশন চালানো
`supabase/migrations/001_initial.sql` ফাইলটি চালিয়ে টেবিলগুলো তৈরি করুন।
`supabase/seed/seed.sql` দিয়ে ডেমো লোকেশন ও পণ্য সিড করতে পারেন।

### 4) অ্যাপ রান
```bash
flutter run
```

## আর্কিটেকচার
```
lib/
  core/
  data/
  domain/
  presentation/
```

## টেস্ট
```bash
flutter test
```
