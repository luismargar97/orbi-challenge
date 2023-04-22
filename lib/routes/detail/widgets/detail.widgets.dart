part of '../detail.route.dart';

class _TextPagesTitles extends StatelessWidget {
  final String label;
  final bool isShowed;
  final VoidCallback changePage;

  const _TextPagesTitles({
    required this.label,
    required this.changePage,
    required this.isShowed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changePage,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: Responsive.dp(1.6),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: isShowed ? blackSnack : blackSnack.withOpacity(0.4),
            ),
          ),
          if (isShowed)
            Container(
              width: Responsive.wp(7),
              height: Responsive.hp(0.2),
              color: blueAlert,
            ),
        ],
      ),
    );
  }
}

class _Page1 extends StatelessView<DetailVM> {
  const _Page1();

  @override
  Widget render(BuildContext context, DetailVM viewModel) {
    return Padding(
      padding: EdgeInsets.all(Responsive.dp(1)),
      child: Column(
        children: [
          Container(
            height: Responsive.hp(10),
            width: Responsive.width,
            margin: EdgeInsets.symmetric(horizontal: Responsive.wp(1)),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(Responsive.dp(2)),
              boxShadow: [
                BoxShadow(
                  color: blackSnack.withOpacity(0.1),
                  blurRadius: 7,
                  spreadRadius: 4,
                  offset: const Offset(1, 3),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TitleLabel(title: 'Height', subtitle: viewModel.pokemon.getHeight()),
                _TitleLabel(title: 'Weight', subtitle: viewModel.pokemon.getWeight()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleLabel extends StatelessWidget {
  final String title;
  final String subtitle;

  const _TitleLabel({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: Responsive.dp(1.6),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: blackSnack.withOpacity(0.4),
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: Responsive.dp(1.4),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: blackSnack,
          ),
        ),
      ],
    );
  }
}

class _Page extends StatelessWidget {
  const _Page();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Cool Info',
      style: TextStyle(fontSize: Responsive.dp(3)),
    ));
  }
}
