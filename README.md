# Introducing VectorDB: The Pocket-Sized Powerhouse for Your Mobile Apps! 🚀

The VectorDB repository provides functionality to create a vector database locally on a device. We were working on a use case that required us to create a privacy-preserving vector database. Therefore, we began searching for a local vector database. We found SVDB, which provides local vector database support for iOS-based applications. However, to the best of our knowledge, no such vector database existed for Android.

One way to address this issue was to write a local vector database for Android similar to SVDB, but the main challenge in this scenario would be managing two different vector databases for both applications. Therefore, we considered writing a unified vector database that can work on both Android and iOS-based applications. In this repository, we have created a Dart-based VectorDB that can be used in Flutter-based applications.

We have benchmarked the performance of our VectorDB against SVDB on the iPhone 14. Additionally, we have also presented results on an Android device to demonstrate that it works on both devices.

Feel free to try it out, and we hope that it will meet your use case.

## VectorDB Highlights ✨

- **No Server, No Cry**: VectorDB runs locally on device. Build your vector db without the hassle of server upkeep!
- **OpenAI's Embeddings Support**: Add OpenAI Embeddings in vectorDB in few lines of code.
- **Custom Embeddings**: Create your own embeddings and add it in vectorDB instead of OpenAI embeddings.
- **Multi-platform Support**: Whether you're team Android or team iOS, VectorDB works on both, making app development a breezy affair.


## Launch Your Journey with VectorDB 🚀

- **Step 1**: Install the Flutter SDK from the [official website](https://flutter.dev/docs/get-started/install).
- **Step 2**: Set up your development environment with your favorite IDE, and install the Dart plugin.
- **Step 3**: Run `flutter doctor` in your terminal to ensure everything is set up properly.
- **Step 4**: Run `git clone https://github.com/FastCodeAI/vectorDB.git` 


# VectorDB Quick Launch: Magic in Minutes! 🎩✨

After you've set up your codebase, it's time to start using vectorDB! Check out the `vector_db_example.dart` in examples folder to see VectorDB in action. Simply run the script from the command line as mentioned below:

```bash
dart example/vector_db_example.dart
```

Want to use VectorDB in your Flutter project? Just add the below command into your pubspec.yaml and start using it:

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


The following table shows the benchmarking results of vectorDB on android phone.

#### Insertion over n documents

| # vectors in DB | vectorDB |
| --------------- | -------- |
|       100		  | 0.264379 |
|       500       | 0.891433 |

#### Searching

| # vectors in DB | vectorDB |
| --------------- | -------- |
|       100		  | 0.067309 |
|       500       | 0.155228 |

##### Note: The time is in seconds.