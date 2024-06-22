class Department{
   final int id;
   final String name;
   final String icon;
   final String url;
   final bool status;
   Department({required this.id, required this.name, required this.icon, required this.url, required this.status});

   factory Department.fromJson(Map<String, dynamic> json) {
     return Department(
       id: json['id'],
       name: json['name'],
       icon: json['icon'],
       url: json['url'],
       status: json['status'] as bool,
     );
   }

   Map<String, dynamic> toJson() {
     return {
       'id': id,
       'name': name,
       'icon': icon,
       'url': url,
       'status': status,
     };
   }

}