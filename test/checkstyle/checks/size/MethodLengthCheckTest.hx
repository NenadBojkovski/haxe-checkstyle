package checkstyle.checks.size;

class MethodLengthCheckTest extends CheckTestCase<MethodLengthCheckTests> {
	@Test
	public function testWrongMethodLength() {
		var check = new MethodLengthCheck();
		check.ignoreEmptyLines = false;
		assertMsg(check, TEST1, "Method `test` length is 354 lines (max allowed is 50)");
	}

	@Test
	public function testCorrectMethodLength() {
		assertNoMsg(new MethodLengthCheck(), TEST2);
	}

	@Test
	public function testConfigurableMethodLength() {
		var check = new MethodLengthCheck();
		check.max = 10;
		check.ignoreEmptyLines = false;

		assertMsg(check, TEST3, "Method `test` length is 14 lines (max allowed is 10)");
	}

	@Test
	public function testIgnoreEmptyLines() {
		var check = new MethodLengthCheck();
		check.max = 10;
		check.ignoreEmptyLines = true;

		assertNoMsg(check, TEST3);

		check.ignoreEmptyLines = false;
		assertMsg(check, TEST3, "Method `test` length is 14 lines (max allowed is 10)");
	}

	@Test
	public function testSuppress() {
		var check = new MethodLengthCheck();
		check.max = 50;
		assertNoMsg(check, SUPPRESS);

		check.max = 5;
		assertNoMsg(check, SUPPRESS);
	}
}

@:enum
abstract MethodLengthCheckTests(String) to String {
	var TEST1 = "
	abstractAndClass Test {
		public function test() {
			trace('TEST');\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n
			\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n
			\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n
			\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n
			\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n
			\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n
			\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n
			\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n
			\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n
			\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n
		}
	}";
	var TEST2 = "
	abstractAndClass Test {
		public function test() {
			trace('TEST');

			trace('TEST');

			trace('TEST');
		}
	}";
	var TEST3 = "
	abstractAndClass Test {
		public function test() {
			trace('TEST');

			trace('TEST');

			trace('TEST');

			trace('TEST');

			trace('TEST');

			trace('TEST');

			// comment
		}

		@SuppressWarnings('checkstyle:MethodLength')
		public function test1() {
			trace('TEST');

			trace('TEST');

			trace('TEST');

			trace('TEST');

			trace('TEST');

			trace('TEST');
		}
	}";
	var SUPPRESS = "
	abstractAndClass Test {
		@SuppressWarnings('checkstyle:MethodLength')
		public function test1() {
			trace('TEST');

			trace('TEST');

			trace('TEST');

			trace('TEST');

			trace('TEST');

			trace('TEST');
		}
	}";
}