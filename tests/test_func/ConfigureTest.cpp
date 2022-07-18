 #include <gtest/gtest.h> 

 #include "/home/laitao/workspaces/sample_project/src/Configure/Configure.h" 
 #include <gmock/gmock.h>  // Brings in Google Mock. 
//  using testing::Return;                              // #1，必要的声明
//  class MockTurtle : public Turtle { 
//     MOCK_METHOD0(PenUp, void()); 
//     MOCK_METHOD0(PenDown, void()); 
//     MOCK_METHOD1(Forward, void(int distance)); 
//     MOCK_METHOD1(Turn, void(int degrees)); 
//     MOCK_METHOD2(GoTo, void(int x, int y)); 
//     MOCK_CONST_METHOD0(GetX, int()); 
//     MOCK_CONST_METHOD0(GetY, int()); 
//  };

// TEST(BarTest, DoesThis) { 
//     MockFoo foo;                                    // #2，创建 Mock 对象
//     ON_CALL(foo, GetSize())                         // #3，设定 Mock 对象默认的行为（可选）
//         .WillByDefault(Return(1)); 
//     // ... other default actions ... 
//     EXPECT_CALL(foo, Describe(5))                   // #4，设定期望对象被访问的方式及其响应
//         .Times(3) 
//         .WillRepeatedly(Return("Category 5")); 
//     // ... other expectations ... 
//     EXPECT_EQ("good", MyProductionFunction(&foo));  
//     // #5，操作 Mock 对象并使用 googletest 提供的断言验证处理结果
// } 


double square_root (double num) { 
    if (num < 0.0) { 
        std::cerr << "Error: Negative Input\n";
         exit(-1);
    }
}

TEST (SquareRootTest, ZeroAndNegativeNos) { 
    ASSERT_EQ (0.0, square_root (0.0));
    ASSERT_EXIT(square_root (-22.0), ::testing::ExitedWithCode(1), "Error: Negative Input\n");
}

    // Code for 0 and +ve numbers follow…       
 TEST(ConfigureTest, addItem) 
 { 
    // do some initialization 
    Configure* pc = new Configure(); 
    
    // validate the pointer is not null 
    ASSERT_TRUE(pc != NULL); 

    // call the method we want to test 
    pc->addItem("A"); 
    pc->addItem("B"); 
    pc->addItem("A"); 

    // validate the result after operation 
    EXPECT_EQ(pc->getSize(), 2); 
    EXPECT_STREQ(pc->getItem(0).c_str(), "A"); 
    EXPECT_STREQ(pc->getItem(1).c_str(), "B"); 
    EXPECT_STREQ(pc->getItem(10).c_str(), ""); 

    delete pc; 
 }

