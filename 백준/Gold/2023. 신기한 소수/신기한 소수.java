import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.StringTokenizer;

public class Main {
    static int N;
    static ArrayList<Integer> li = new ArrayList<>();
    static boolean isP(int n) {
        for(int i = 2; i*i <= n; i++) {
            if ((n%i) == 0) { return false; }
        }
        return true;
    }
    static void find() {
        int a = 0;
        if (!li.isEmpty()){
            a = li.stream().reduce((a1,b1) -> a1*10 + b1).get();
            if (!isP(a)) { return; }
        }
        if (li.size() == N) {
            System.out.println(a);
            return;
        }
        for(int i = 1; i < 10; i++) {
            if (li.size() == 0 && 1 == i ) { continue; }

            li.add(i);
            find();
            li.remove(li.size()-1);
        }
    }
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        N = Integer.parseInt(st.nextToken());
        find();
    }
}