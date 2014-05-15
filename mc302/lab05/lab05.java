package lab05;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 
 * @author ra146446
 * 
 */
public class lab05 {

	// names: stores StudentsNames and NameRepetition
	// ids: stores StudentsIds and IdsRepetitions
	// courses: store CoursesNames and CoursesRepetitions (number of Students)
	private static Map<String, Integer> names = new HashMap<String, Integer>();
	private static Map<String, Integer> ids = new HashMap<String, Integer>();
	private static Map<String, Integer> courses = new HashMap<String, Integer>();

	public static void main(String args[]) {
		String csvFile = "alunos.csv";
		processFile(csvFile);

		/**
		 * Prints homonyms: Homonyms - Number of Repetitions
		 */
		System.out.println("Homonimos:");
		for (Map.Entry<String, Integer> name : names.entrySet()) {
			if (name.getValue() > 1)
				System.out.println(name.getKey() + "\t" + name.getValue());
		}
		System.out.println("\n");

		/**
		 * Prints Repeated Ids: Repeated Ids - Number of Repetitions
		 */
		System.out.println("Documentos repitidos:");
		for (Map.Entry<String, Integer> id : ids.entrySet()) {
			if (id.getValue() > 1)
				System.out.println(id.getKey() + "\t" + id.getValue());
		}
		System.out.println("\n");

		/**
		 * Prints Courses and number Of students by course: Course Name - Number
		 * of students
		 */
		System.out.println("Cursos e numero de alunos:");
		for (Map.Entry<String, Integer> course : courses.entrySet()) {
			System.out.println(course.getKey() + "\t" + course.getValue());
		}
		System.out.println("\n");

	}

	/**
	 * 
	 * @param name
	 *            : file name of file to be processed Method to process files
	 *            and fills names, ids and courses
	 */
	public static void processFile(String name) {

		try {

			// reader: stores data to be read
			// line: string containing line to be processed
			// attributes: String array containing each attribute present in a
			// file line
			BufferedReader reader = new BufferedReader(new FileReader(name));
			String line = null;
			String[] attributes;

			/**
			 * iterates through each line of file
			 */
			while ((line = reader.readLine()) != null) {

				/**
				 * parses attributes separated by semicolon
				 */
				attributes = line.split(";");

				/**
				 * fills names: increments value if student name already exists,
				 * otherwise adds a student name with repetition one
				 */
				if (names.containsKey(attributes[0]))
					names.put(attributes[0], names.get(attributes[0]) + 1);
				else
					names.put(attributes[0], 1);

				/**
				 * fills ids: increments value if ids already exists, otherwise
				 * adds a ids with repetition one
				 */
				if (ids.containsKey(attributes[1]))
					ids.put(attributes[1], ids.get(attributes[1]) + 1);
				else
					ids.put(attributes[1], 1);

				/**
				 * fills courses: increments value (number of students) if
				 * courses already exists, otherwise adds a course with
				 * repetition one (number of students one)
				 */
				if (courses.containsKey(attributes[3]))
					courses.put(attributes[3], courses.get(attributes[3]) + 1);
				else
					courses.put(attributes[3], 1);

			}
			reader.close();
		} catch (FileNotFoundException e) {
			// Catches BufferedReader exception
			e.printStackTrace();
		} catch (IOException e) {
			// Catches put method exception
			e.printStackTrace();
		}
	}

}
