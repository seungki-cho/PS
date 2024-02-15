import java.util.*;
import java.io.*;

public class Solution {
    static ArrayList<ArrayList<Integer>> sequences = new ArrayList<>();
    static ArrayList<Integer> sequence = new ArrayList<>();
    static int[] opponent = new int[9];
    static int[] mine = new int[9];
    static int wincount;
    static int losecount;

    static void game(int j) {
        int notMyScore = 0;
        int myScore = 0;
        for(int i = 0; i < 9; i++){
            if (opponent[i] > mine[sequences.get(j).get(i)]) {
                notMyScore += opponent[i] + mine[sequences.get(j).get(i)];
            } else {
                myScore += opponent[i] + mine[sequences.get(j).get(i)];
            }
        }
        if (myScore > notMyScore) {
            wincount++;
        } else if (myScore < notMyScore) {
            losecount++;
        }
    }
    static void recursion() {
        if(sequence.size() == 9) {
            sequences.add((ArrayList<Integer>) sequence.clone());
            return;
        }
        for(int i = 0; i < 9; i++) {
            if (!sequence.contains(i)) {
                sequence.add(i);
                recursion();
                sequence.remove(sequence.size()-1);
            }
        }
    }

    public static void main(String[] args) throws Exception{
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        int T = Integer.parseInt(br.readLine());
        StringBuilder sb = new StringBuilder();
        recursion();

        for(int t = 1; t <= T; t++) {
            StringTokenizer st = new StringTokenizer(br.readLine());
            Set<Integer> opset = new HashSet<>();
            wincount = 0;
            losecount = 0;
            opponent = new int[9];
            mine = new int[9];

            for(int i = 0; i < 9; i++){
                opponent[i] = Integer.parseInt(st.nextToken());
                opset.add(opponent[i]);
            }

            for(int i = 1, j = 0; i < 19; i++) {
                if (!opset.contains(i)) {
                    mine[j++] = i;
                }
            }

            for (int i = 0; i < sequences.size(); i++) {
                game(i);
            }

            sb.append("#" + t + " " + losecount + " " + wincount).append("\n");
        }
        System.out.println(sb);
    }
}



/*
4
1 3 5 7 9 11 13 15 17
18 16 14 12 10 8 6 4 2
13 17 9 5 18 7 11 1 15
1 6 7 9 12 13 15 17 18
 */