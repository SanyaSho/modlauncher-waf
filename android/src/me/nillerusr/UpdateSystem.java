package me.nillerusr;

import com.valvesoftware.source.mod.R;

import android.content.*;
import java.io.*;
import java.net.*;
import android.os.AsyncTask;
import java.net.URL;
import java.net.URLConnection;
import java.io.InputStream;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import android.util.Log;
import me.nillerusr.UpdateService;

public class UpdateSystem extends AsyncTask< String, Integer, String >
{
	Context mContext;
	String commit;
	static String git_url;
	static String apk_url;

	public UpdateSystem( Context context )
	{
		mContext = context; // save application context
		commit = context.getResources().getString( R.string.current_commit );

		git_url = context.getResources().getString( R.string.update_url );
		apk_url = "http://127.0.0.1/";
	}

	private static String toString( InputStream inputStream )
	{
		String[] update;
		try
		{
			BufferedReader bufferedReader = new BufferedReader( new InputStreamReader( inputStream, "UTF-8" ) );
			String inputLine;
			StringBuilder stringBuilder = new StringBuilder();
			while( ( inputLine = bufferedReader.readLine() ) != null )
			{
				stringBuilder.append( inputLine );
			}
			update = stringBuilder.toString().split( ":", 2 );

			apk_url = update[ 1 ]; // url
			return update[ 0 ]; // commit
		}
		catch( Exception e )
		{
		}

		return "";
	}

	@Override
	protected String doInBackground( String... params )
	{
		URL urlObject;
		URLConnection urlConnection;

		try
		{
			urlObject = new URL( git_url );
			urlConnection = urlObject.openConnection();

			String web_commit = toString( urlConnection.getInputStream() );

			Log.d( "UpdateSystem", String.format( "%s | %s", web_commit, commit ) );

			return web_commit;
		}
		catch( IOException e )
		{
		}

		return null;
	}

	protected void onPostExecute( String result )
	{
		if( result != null && !result.equals( "" ) && !commit.equals( result ) )
		{
			Intent notif = new Intent( mContext, UpdateService.class );
			notif.putExtra( "url", apk_url );
			mContext.startService( notif );
		}
	}
}
