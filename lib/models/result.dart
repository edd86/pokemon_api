// To parse this JSON data, do
//
//     final result = resultFromJson(jsonString);

class Result {
    final int count;
    final String next;
    final dynamic previous;
    final List<ResultElement> results;

    Result({
        required this.count,
        required this.next,
        required this.previous,
        required this.results,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<ResultElement>.from(json["results"].map((x) => ResultElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class ResultElement {
    final String name;
    final String url;

    ResultElement({
        required this.name,
        required this.url,
    });

    factory ResultElement.fromJson(Map<String, dynamic> json) => ResultElement(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}
