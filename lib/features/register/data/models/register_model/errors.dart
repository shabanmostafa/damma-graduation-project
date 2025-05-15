class Errors {
	List<String>? email;
	List<String>? lastName;
	List<String>? password;
	List<String>? firstName;
	List<String>? dateOfBirth;

	Errors({
		this.email, 
		this.lastName, 
		this.password, 
		this.firstName, 
		this.dateOfBirth, 
	});

	factory Errors.fromJson(Map<String, dynamic> json) => Errors(
				email: json['Email'] as List<String>?,
				lastName: json['LastName'] as List<String>?,
				password: json['Password'] as List<String>?,
				firstName: json['FirstName'] as List<String>?,
				dateOfBirth: json['DateOfBirth'] as List<String>?,
			);

	Map<String, dynamic> toJson() => {
				'Email': email,
				'LastName': lastName,
				'Password': password,
				'FirstName': firstName,
				'DateOfBirth': dateOfBirth,
			};
}
