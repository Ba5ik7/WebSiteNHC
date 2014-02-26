package com.wes.objects
{
	public class MailInfoObj
	{
		
		public var firstName : String = new String();
		public var lastName : String = new String();
		public var email : String = new String();
		public var birthMonth : String = new String();
		public var spouseBirthMonth : String = new String();
		public var anniversaryMonth : String = new String();

		public function MailInfoObj(_firstName : String, _lastName : String, _email : String, _birthMonth : String, _spouseBirthMonth : String, _anniversaryMonth : String) {
			firstName = _firstName;
			lastName = _lastName;
			email = _email;
			birthMonth = _birthMonth;
			spouseBirthMonth = _spouseBirthMonth;
			anniversaryMonth = _anniversaryMonth;
		}
	}
}