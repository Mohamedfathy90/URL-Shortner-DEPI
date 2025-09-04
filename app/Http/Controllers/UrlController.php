<?php

namespace App\Http\Controllers;

use App\Models\Url;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class UrlController extends Controller
{
    public function index()
    {
        return view('shortener');
    }

    public function store(Request $request)
    {
        $request->validate([
            'url' => 'required|url'
        ]);

        $code = Str::random(6);

        $short = Url::create([
            'code' => $code,
            'long_url' => $request->url
        ]);

        return view('shortener', [
            'shortUrl' => url($short->code)
        ]);
    }

    public function redirect($code)
    {
        $url = Url::where('code', $code)->firstOrFail();
        return redirect()->to($url->long_url);
    }
}
