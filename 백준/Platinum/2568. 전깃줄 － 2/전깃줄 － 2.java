import java.util.*;
import java.io.*;

public class Main {
    public static void main(String[] args) throws Exception{
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        int N = Integer.parseInt(br.readLine());
        Pair[] li = new Pair[N];
        for (int i = 0; i < N; i++) {
            StringTokenizer st = new StringTokenizer(br.readLine());
            li[i] = new Pair(Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken()));
        }
        Arrays.sort(li);
        ArrayList<Integer> dp = new ArrayList<>();
        dp.add(li[0].y);
        Pair[] rem = new Pair[N];

        for (int i = 0; i < N; i++) {
            if (dp.get(dp.size()-1) < li[i].y) {
                dp.add(li[i].y);
                rem[i] = new Pair(li[i].y, dp.size() - 1);
                continue;
            }
            int index = Collections.binarySearch(dp, li[i].y);
            index = index < 0 ? (-index-1) : index;
            rem[i] = new Pair(li[i].y, index);
            dp.set(index, li[i].y);
        }

        int[] ans = new int[dp.size()];
        int index = ans.length - 1;
        for (int i = N-1; i >= 0; i--) {
            if (rem[i].y == index) {
                ans[index] = rem[i].x;
                index--;
            }
        }
        Set<Integer> set = new HashSet<>();
        for (int i = 0; i < ans.length; i++) {
            set.add(ans[i]);
        }
        StringBuilder sb = new StringBuilder();
        sb.append(N-ans.length).append("\n");
        for (int i = 0; i < N; i++) {
            if (!set.contains(li[i].y)) {
                sb.append(li[i].x).append("\n");
            }
        }

        System.out.println(sb);
    }
    static class Pair implements Comparable<Pair>{
        int x; int y;
        public Pair(int x, int y) {
            this.x = x;
            this.y = y;
        }

        @Override
        public int compareTo(Pair o) {
            return Integer.compare(x, o.x);
        }
    }
}