#include <gmock/gmock.h>
#include "/home/laitao/workspaces/sample_project/src/calculate/calc.h"
//#include <gtest/gtest.h>
#include "Soundex.h"

using namespace testing;

//创建一个fixture类，每一组测试都使用一个fixture类
class SoundexEncoding : public Test
{
public:
    Soundex soundex;
protected:
    virtual void SetUp(){
        std::cout<< "开始测试啦"<<std::endl;

    }
    virtual void TearDown(){
       std::cout<< "测试结束啦"<<std::endl; 
    }
};


TEST_F(SoundexEncoding,ReplacesConsonantsWithAppropriateDigits)
{
    std::cout<< "测试中"<<std::endl;
    ASSERT_THAT(soundex.encode("Ax"),Eq("A200"));
}

TEST_F(SoundexEncoding,PadsWithZerosToEnsureThreeDigits)
{   
    ASSERT_THAT(soundex.encode("Ib"),Eq("I100"));
}

TEST_F(SoundexEncoding,IgnoresNonAlphabetics)
{
    ASSERT_THAT(soundex.encode("A#"),Eq("A000"));
}

TEST_F(SoundexEncoding,ReplacesMultipConsonantsWithDigits)
{
    ASSERT_THAT(soundex.encode("Acdl"),Eq("A234"));
}

TEST_F(SoundexEncoding,LimitsLengthToFourCharacters)
{
    ASSERT_THAT(soundex.encode("Dcdlb").length(),Eq(4u));
}

TEST_F(SoundexEncoding, IgnoresVowelLikeLetters) 
{
    ASSERT_THAT(soundex.encode("Baeiouhycdl"), Eq("B234"));
}

TEST_F(SoundexEncoding, CombinesDuplicateEncodings) 
{
    ASSERT_THAT(soundex.encodedDigit('b'),
    Eq(soundex.encodedDigit('f')));
    ASSERT_THAT(soundex.encodedDigit('c'),
    Eq(soundex.encodedDigit('g')));
    ASSERT_THAT(soundex.encodedDigit('d'),
    Eq(soundex.encodedDigit('t')));

    ASSERT_THAT(soundex.encode("Abfcgdt"), Eq("A123"));
}

TEST_F(SoundexEncoding, UppercasesFirstLetter) 
{
    ASSERT_THAT(soundex.encode("baAeEiIoOuUhHyYcdl"), Eq("B234"));
}

TEST_F(SoundexEncoding, IgnoresCaseWhenEncodingConsonants) 
{
    ASSERT_THAT(soundex.encode("BCDL"),Eq(soundex.encode("Bcdl")));
}

TEST_F(SoundexEncoding,CombinesDuplicateCodesWhen2ndLetterDuplicates1st) 
{
    ASSERT_THAT(soundex.encode("Bbcd"), Eq("B230"));
}

TEST_F(SoundexEncoding,DoesNotCombineDuplicateEncodingsSeparatedByVowels) 
{
    ASSERT_THAT(soundex.encode("Jbob"), Eq("J110"));
}

TEST(calculate,test_add_result) 
{
    EXPECT_EQ(5, add(2,3));
}
