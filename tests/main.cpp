
#include <iostream>
#include <gmock/gmock.h>
#include <gtest/gtest.h>
#include <string>
#include "/home/laitao/workspaces/sample_project/tests/test_mock/FooMock.h"

#include "/home/laitao/workspaces/sample_project/tests/test_mock/MockIAPIProviderInterface.h"
#include "/home/laitao/workspaces/sample_project/tests/test_mock/MockIParameterInterface.h"
#include "/home/laitao/workspaces/sample_project/tests/test_mock/Rank.h"
#include <boost/cstdint.hpp>
#include <boost/shared_ptr.hpp>
using namespace seamless;
using namespace std;
using ::testing::Return;


using ::testing::_;
using ::testing::AtLeast;
using ::testing::DoAll;
using ::testing::SetArgumentPointee;

int main(int argc,char** argv)
{
    ::testing::InitGoogleMock(&argc, argv);

        MockIAPIProviderInterface* iAPIProvider = new MockIAPIProviderInterface;
        MockIParameterInterface* iParameter = new MockIParameterInterface;

        EXPECT_CALL(*iAPIProvider, getParameterInterface()).Times(AtLeast(1)).
                WillRepeatedly(Return(iParameter));

        boost::shared_ptr<VariantField> retailWholesaleValue(new VariantField);
        retailWholesaleValue->strVal = "0";

        boost::shared_ptr<VariantField> defaultValue(new VariantField);
        defaultValue->strVal = "9";

        EXPECT_CALL(*iParameter, getParameter(_, _)).Times(AtLeast(1)).
                WillOnce(DoAll(SetArgumentPointee<1>(*retailWholesaleValue), Return(1))).
                WillRepeatedly(DoAll(SetArgumentPointee<1>(*defaultValue), Return(1)));

        Rank rank;
        rank.processQuery(iAPIProvider);

        delete iAPIProvider;


    cout<<"Hello World!"<<endl;
    string value = "Hello World!";
    MockFoo mockFoo;
    EXPECT_CALL(mockFoo, getArbitraryString()).Times(1).
    WillOnce(Return(value));
    string returnValue = mockFoo.getArbitraryString();
    cout << "Returned Value: " << returnValue << endl;
    testing::InitGoogleTest(&argc,argv);
    return RUN_ALL_TESTS();
}
