// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dad_joke/app/detail/joke_view.dart';
import 'package:dad_joke/app/home/bloc/joke_bloc.dart';
import 'package:dad_joke/app/home/screen/builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


// ignore: must_be_immutable
class JokeHomePage extends StatefulWidget {
  String? userName;
   JokeHomePage({
    super.key,
    this.userName,
  });

  @override
  State<JokeHomePage> createState() => _JokeHomePageState();
}

class _JokeHomePageState extends HomeBuilder {
  late JokeBloc jokeBloc;
  final TextEditingController searchJokeController = TextEditingController();

  var joke;
  @override
  void initState() {
    jokeBloc = JokeBloc();
    searchJokes();
    super.initState();
  }

  searchJokes() {
    jokeBloc
        .add(FetchJokesFromApiEvent(searchKeyWord: searchJokeController.text));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: appDrawer(widget.userName.toString(),context),
        appBar: AppBar(
           iconTheme:const IconThemeData(
          color: Colors.white, // Change the drawer icon color here
        ),
          title: Text(
            "DAD JOKE",
            style: GoogleFonts.sarala(color: Colors.white, fontSize: 20),
          ),
          backgroundColor: const Color(0xff2f3e46),
        ),
        body: BlocConsumer<JokeBloc, JokeHomeState>(
          bloc: jokeBloc,
          listenWhen: (previous, current) => current is JokeHomeActionState,
          buildWhen: (previous, current) => current is! JokeHomeActionState,
          listener: (context, state) {
            if (state is NavigateToJokeDetailsViewActionState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => JokeDetailView(joke: joke)));
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case JokeLoadingState:
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );

              case JokeLoadedSuccessState:
                final successState = state as JokeLoadedSuccessState;
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      padding: const EdgeInsets.only(left: 8, top: 6, right: 3),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xffced4da)),
                      child: TextField(
                        controller: searchJokeController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'search jokes.....',
                            hintStyle: TextStyle(
                                color: const Color(0xff2f3e46).withOpacity(.6)),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  searchJokes();
                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: Color(0xff2f3e46),
                                ))),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: successState.jokeDataList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  joke = successState.jokeDataList[index].joke
                                      .toString();
                                });
                                jokeBloc.add(NavigateToJokeDetailsViewEvent());
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                padding: const EdgeInsets.all(10),

                                // alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color(0xffced4da),
                                    borderRadius: BorderRadius.circular(7)),
                                width: size.width,
                                child: ListTile(
                                  subtitle: Text(
                                    successState.jokeDataList[index].joke
                                        .toString(),
                                    style: GoogleFonts.urbanist(
                                        color: const Color(0xff2f3e46)),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              case JokeFailedErrorState:
                return const Center(
                  child: Text('Error Occured'),
                );
              default:
                return const Center(
                  child: Text('this state not working'),
                );
            }
          },
        ),
      ),
    );
  }
}
