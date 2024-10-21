class Movie {
  final String title;
  final String year;
  final String imdbID;
  final String? poster; // Nullable
  final String type;

  Movie({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    this.poster,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? '', // Provide default values for safety
      year: json['Year'] ?? '',
      imdbID: json['imdbID'] ?? '',
      poster: json['Poster'], // This can be null
      type: json['Type'] ?? '',

    );
  }

  Map<String, dynamic> toJson() => {
        'Title': title,
        'Year': year,
        'imdbID': imdbID,
        'Poster': poster,
        'Type': type,
      };
}