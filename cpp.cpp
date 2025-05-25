#include <bits/stdc++.h>

using namespace std;

string ltrim(const string &);
string rtrim(const string &);

/**
 * @brief Compare two pairs for sorting
 * @param a First pair
 * @param b Second pair
 * @return true if a should come before b, false otherwise
*/
bool compare_pairs(const pair<string, int>& a, const pair<string, int>& b) {
    if (a.second == b.second) {
        return a.first < b.first;
    }
    return a.second > b.second;
}


/**
 * @brief Complete the 'groupTransactions' function below.
 * 
 * @param transactions The function accepts STRING_ARRAY transactions as parameter.
 * @return vector<string> The function is expected to return a STRING_ARRAY.
*/
vector<string> groupTransactions(vector<string> transactions) {
    vector<string> result;
    map<string, int> word_count;
    map<string, int>::iterator it;
    
    for(string transaction : transactions){
        it =  word_count.find(transaction);

        if(it != word_count.end()){
            it->second++;
        } else {
            word_count[transaction] = 1;
        }
    }

    // create a vector of pairs from the map
    vector<pair<string, int>> sorted_word_count(word_count.begin(), word_count.end());

    sort(sorted_word_count.begin(), sorted_word_count.end(), compare_pairs);

    /* 
        // Alternative sorting using lambda function (using inline )
        // Sort the vector of pairs based on the count and then alphabetically
        // If the count is the same, sort alphabetically
        sort(sorted_word_count.begin(), sorted_word_count.end(), 
            [](const pair<string, int>& a, const pair<string, int>& b) {
            if (a.second == b.second) {
                return a.first < b.first;
            }
            return a.second > b.second;
        });
    */

    for (const pair<string, int>& p : sorted_word_count) {
        result.push_back(p.first + " " + to_string(p.second));
    }

    return result;
}

int main()
{
    ofstream fout(getenv("OUTPUT_PATH"));

    string transactions_count_temp;
    getline(cin, transactions_count_temp);

    int transactions_count = stoi(ltrim(rtrim(transactions_count_temp)));

    vector<string> transactions(transactions_count);

    for (int i = 0; i < transactions_count; i++) {
        string transactions_item;
        getline(cin, transactions_item);

        transactions[i] = transactions_item;
    }

    vector<string> result = groupTransactions(transactions);

    for(string element : result) {
        cout << element << endl;
    };

    for (int i = 0; i < result.size(); i++) {
        fout << result[i];

        if (i != result.size() - 1) {
            fout << "\n";
        }
    }

    fout << "\n";

    fout.close();

    return 0;
}

string ltrim(const string &str) {
    string s(str);

    s.erase(
        s.begin(),
        find_if(s.begin(), s.end(), not1(ptr_fun<int, int>(isspace)))
    );

    return s;
}

string rtrim(const string &str) {
    string s(str);

    s.erase(
        find_if(s.rbegin(), s.rend(), not1(ptr_fun<int, int>(isspace))).base(),
        s.end()
    );

    return s;
}

