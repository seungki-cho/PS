import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.StringTokenizer;

public class Main {
    /**
     * @param args
     * @throws IOException
     */
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        Pair[] li = new Pair[N];

        for(int i = 0; i < N; i++) {
            st = new StringTokenizer(br.readLine());
            li[i] = new Pair(Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken()));
        }

        Arrays.sort(li);
        ArrayList<Integer> tr = new ArrayList();
        tr.add(li[0].j);
        for(int i = 1; i < N; i++) {
            if (tr.get(tr.size()-1) < li[i].j) {
                tr.add(li[i].j);
                continue;
            }
            int a = bs(tr, li[i].j);
            tr.set(a, li[i].j);
        }
        System.out.println(N-tr.size());

    }    
    static class Pair implements Comparable<Pair> {
        int i;
        int j;
        Pair(int i, int j) {
            this.i = i;
            this.j = j;
        }
        @Override
        public int compareTo(Main.Pair o) {
            return this.i < o.i ? -1 : 1;
        }
    }
    static int bs(List<Integer> li, int target) {
        int left = 0;
        int right = li.size();

        while (left < right) {
            int mid = (left + right) / 2;

            if (li.get(mid) < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return left;
    }

}
