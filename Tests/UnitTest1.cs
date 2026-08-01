namespace Bnfour.WorkflowTesting.Proper.Tests;

public class UnitTest1
{
    // yeah, there's not a lot to actually test except the long text,
    // so whatever

    [Fact]
    public void TheTest()
    {
        Assert.True(true);
    }

    [Theory]
    [InlineData(2, 2, 4)]
    [InlineData(0, 0, 0)]
    public void MathTest(int a, int b, int sum)
    {
        Assert.Equal(sum, a + b);
    }
}
