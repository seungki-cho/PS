import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.StringTokenizer;

public class Main {
    static int N;
    static int M;
    static ArrayList<Integer> arr;
    static void find() {
        if (arr.size() == M) {
            for(int i = 0; i < M; i++){
                System.out.print(arr.get(i) + " ");
            }
            System.out.println();
            return;
        }

        for(int i = 1; i <= N; i++) {
            if (arr.contains(i)) { continue; }

            arr.add(i);
            find();
            arr.remove(arr.size()-1);
        }
    }
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        N = Integer.parseInt(st.nextToken());
        M = Integer.parseInt(st.nextToken());
        arr = new ArrayList<>();
        find();
    }
}