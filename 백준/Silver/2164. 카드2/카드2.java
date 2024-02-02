import java.io.*;
import java.util.*;

public class Main {
    static int N;

    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        N = Integer.parseInt(st.nextToken());
        LinkedList<Integer> li = new LinkedList<>();
        for (int i = 1; i <= N; i++) {
            li.add(i);
        }
        while (li.size() != 1) {
            li.removeFirst();
            li.addLast(li.removeFirst());
        }
        System.out.println(li.get(0));
    }
}