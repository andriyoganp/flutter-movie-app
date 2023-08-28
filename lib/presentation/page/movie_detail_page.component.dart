part of 'movie_detail_page.dart';

class _GenreNames extends StatelessWidget {
  const _GenreNames(this.names);

  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(
        names.length,
        (int index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 4,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (index != 0)
                  Icon(
                    Icons.circle,
                    color: UiColors.primary,
                    size: 4,
                  ),
                if (index != 0) const SizedBox(width: 4),
                Text(
                  names[index],
                  style: TextStyle(
                    color: UiColors.white.withOpacity(0.7),
                    fontFamily: Fonts.sfProText,
                    fontWeight: Fonts.sfProTextRegular,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CastItem extends StatelessWidget {
  const _CastItem(this.cast);

  final Cast cast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              imageUrl: cast.profilePath.imageMovieUrl,
              placeholder: (_, __) {
                return const ImagePlaceholder(radius: 50);
              },
              fit: BoxFit.fitWidth,
              height: 90,
              width: 90,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            cast.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: Fonts.sfProText,
              color: UiColors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({this.isFavorite = false, this.onPressed});

  final bool isFavorite;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: isFavorite ? UiColors.primary : Colors.transparent,
        side: BorderSide(
          color: UiColors.white.withOpacity(0.12),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            isFavorite ? Icons.remove : Icons.add_rounded,
            color: isFavorite ? UiColors.white : UiColors.primary,
          ),
          const SizedBox(width: 4),
          Text(
            isFavorite ? 'Delete Favorite' : 'Add To Favorite',
            style: TextStyle(
              color: UiColors.white,
              fontFamily: Fonts.sfProText,
              fontWeight: Fonts.sfProTextRegular,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _CastFailurePlaceholder extends StatelessWidget {
  const _CastFailurePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Cannot load data',
        style: TextStyle(
          color: UiColors.white,
          fontFamily: Fonts.sfProText,
          fontWeight: Fonts.sfProTextMedium,
          fontSize: 16,
        ),
      ),
    );
  }
}
