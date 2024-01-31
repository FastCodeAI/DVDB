# Introducing VectorDB: The Pocket-Sized Powerhouse for Your Mobile Apps! 🚀

Ever felt the frustration of juggling between different databases for iOS and Android? Fret no more! We embarked on a heroic quest to create a local vector database that feels right at home on both Android and iOS. Enter **VectorDB** - your go-to solution for maintaining harmony in the mobile development realm. 🌐✨

Born out of the need for a universal solution, we stumbled upon [SVDB](https://github.com/Dripfarm/SVDB) while building an iOS app. It was like finding a needle in a haystack, but for Android, the haystack was, well, needle-less. So we rolled up our sleeves and brewed our own concoction. After much tinkering, testing, and a few coffee spills, VectorDB came to life! It's like the Swiss Army knife for your mobile apps, only cooler and without the risk of nicking your finger.

VectorDB is not just a database; it's a marvel in a class of its own. With its fluttering Dart wings, it seamlessly integrates into your mobile habitat. Need to make sense of your data? Just whisper sweet nothings to the OpenAI API, and it'll transform your input text into meaningful embeddings. More of a DIY enthusiast? Craft your own custom embeddings and let VectorDB embrace them with open arms.

We're not just sharing a tool; we're handing over a torch. VectorDB is now open-source because good things in life are meant to be shared, like pizza... or Wi-Fi passwords. So, if you're looking to amp up your app with some local vector database magic, VectorDB is your loyal companion. It's like having a mini superhero in your pocket, ready to leap into action at a moment's notice!

Join us in this journey, contribute your genius, and let's make mobile development a tad more delightful, one vector at a time. 🌟

Happy coding! 🎉✨


## VectorDB Highlights ✨

- **No Server, No Cry**: VectorDB lives cozily on your device. Build your fortress of vectors without the hassle of server upkeep!
- **OpenAI's Right Hand**: With OpenAI Embedding support, VectorDB is like having a data wizard by your side.
- **Custom Embedding Wizardry**: Conjure up your own embeddings and watch VectorDB weave them into its magical data tapestry.
- **Unity in Diversity**: Whether you're team Android or an iOS aficionado, VectorDB speaks your language, making app development a breezy affair.


## Launch Your Journey with VectorDB 🚀

- **Step 1**: Install the Flutter SDK from the [official website](https://flutter.dev/docs/get-started/install).
- **Step 2**: Set up your development environment with your favorite IDE, and install the Dart plugin.
- **Step 3**: Run `flutter doctor` in your terminal to ensure everything is set up properly.
- **Step 4**: Run `git clone https://github.com/FastCodeAI/vectorDB.git` 


# VectorDB Quick Launch: Magic in Minutes! 🎩✨

Feeling adventurous? After you've set up your codebase castle, it's time to unleash the dragon! Check out the `vector_db_example.dart` in our treasure chest to see VectorDB in action. Simply summon the script from the command line like a true code wizard:

```bash
dart example/vector_db_example.dart
```

Want to make VectorDB your loyal sidekick in your Flutter project? Just whisper these magical incantations into your pubspec.yaml and behold as it joins your quest:

```
vectorDB:
    path: ./path_to_vectorDB_folder/vectorDB/
```


## Explore More About VectorDB 🔍

### Benchmakring Results:

The following table shows the benchmarking results on SVDB as compared to vectorDB on iPhone 14.

#### Insertion over n documents

| # vectors in DB |  SVDB  | vectorDB |
| --------------- | ------ | --------- |
|       100		  | 9.8013 | 0.0159 |
|       500       | 277.903 | 0.04536 |


#### Searching

| # vectors in DB |    SVDB   |  vectorDB |
| --------------- | --------- | --------- |
|       100		  | 0.0349418 | 0.0159485 |
|       500       | 0.0937644 | 0.0333472 |


##### Note: The time is in seconds.