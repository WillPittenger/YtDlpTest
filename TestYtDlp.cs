// Ignore Spelling: Dlp

using Python.Runtime;

namespace YtDlpTest;

[System.Management.Automation.Cmdlet(System.Management.Automation.VerbsDiagnostic.Test, "YtDlp")]
public class TestYtDlp : System.Management.Automation.Cmdlet
{
	public TestYtDlp()
	{
		Runtime.PythonDLL = "python37.dll";

		PythonEngine.Initialize();
		PythonEngine.BeginAllowThreads();

		yt = Py.Import("yt_dlp");
	}

	~TestYtDlp()
		=> PythonEngine.Shutdown();

	private readonly dynamic yt;

	protected override void ProcessRecord()
	{
		base.ProcessRecord();

		using Py.GILState lockInfo = Py.GIL();

		WriteObject(yt.version.__version__);
	}
}