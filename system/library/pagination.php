<?php

class Pagination {

    public $total = 0;
    public $page = 1;
    public $limit = 20;
    public $num_links = 10;
    public $num_pages = 10;
    public $url = '';
    public $text = 'Showing {start} to {end} of {total} ({pages} Pages)';
    public $text_first = '|&lt;';
    public $text_last = '&gt;|';
    public $text_next = '&gt;';
    public $text_prev = '&lt;';
    public $style_links = 'links';
    public $style_results = 'results';
    
    private function getPage () {
        if ($this->page < 1) {
            $page = 1;
        } else {
            $page = $this->page;
        }
        return $page;
    }
    
    private function getLimit () {
        if (!(int) $this->limit) {
            $limit = 10;
        } else {
            $limit = $this->limit;
        }
        return $limit;
    }
    
    private function getNumPages () {
        $num_pages = ceil($this->total / $this->getLimit());
        return $num_pages;
    }

    public function render() {
        $total = $this->total;

        $page = $this->getPage();
        
        $limit = $this->getLimit();
        
        $num_links = $this->num_links;
        $num_pages = $this->getNumPages();

        $output = '';

        if ($page > 1) {
            if ($this->text_first != "") {
                $output .= ' <a href="' . str_replace('{page}', 1, $this->url) . '" class="first"><span>' . $this->text_first . '</span></a>';
            }
            $output .= '<a href="' . str_replace('{page}', $page - 1, $this->url) . '" class="prev"><span>' . $this->text_prev . '</span></a> ';
        }

        if ($num_pages > 1) {
            if ($num_pages <= $num_links) {
                $start = 1;
                $end = $num_pages;
            } else {
                $start = $page - floor($num_links / 2);
                $end = $page + floor($num_links / 2);

                if ($start < 1) {
                    $end += abs($start) + 1;
                    $start = 1;
                }

                if ($end > $num_pages) {
                    $start -= ($end - $num_pages);
                    $end = $num_pages;
                }
            }

            if ($start > 1) {
                $output .= ' .... ';
            }

            for ($i = $start; $i <= $end; $i++) {
                if ($page == $i) {
                    $output .= ' <strong>' . $i . '</strong> ';
                } else {
                    $output .= ' <a href="' . str_replace('{page}', $i, $this->url) . '"><span>' . $i . '</span></a> ';
                }
            }

            if ($end < $num_pages) {
                $output .= ' .... ';
            }
        }

        if ($page < $num_pages) {
            
            $output .= ' <a href="' . str_replace('{page}', $page + 1, $this->url) . '" class="next"><span>' . $this->text_next . '</span></a>';            
            if ($this->text_last != "") { 
                $output .= '<a href="' . str_replace('{page}', $num_pages, $this->url) . '" class="last"><span>' . $this->text_last . '</span></a>';
            }
        }

        $find = array(
            '{start}',
            '{end}',
            '{total}',
            '{pages}'
        );

        $replace = array(
            ($total) ? (($page - 1) * $limit) + 1 : 0,
            ((($page - 1) * $limit) > ($total - $limit)) ? $total : ((($page - 1) * $limit) + $limit),
            $total,
            $num_pages
        );

        return ($output ? '<div class="' . $this->style_links . '">' . $output . '</div>' : '');
    }

    public function text() {
        $total = $this->total;

        $page = $this->getPage();
        
        $limit = $this->getLimit();
        
        $num_links = $this->num_links;
        $num_pages = $this->getNumPages();

        $output = '';

        if ($page > 1) {
            $output .= ' <a href="' . str_replace('{page}', 1, $this->url) . '">' . $this->text_first . '</a> <a href="' . str_replace('{page}', $page - 1, $this->url) . '">' . $this->text_prev . '</a> ';
        }

        if ($num_pages > 1) {
            if ($num_pages <= $num_links) {
                $start = 1;
                $end = $num_pages;
            } else {
                $start = $page - floor($num_links / 2);
                $end = $page + floor($num_links / 2);

                if ($start < 1) {
                    $end += abs($start) + 1;
                    $start = 1;
                }

                if ($end > $num_pages) {
                    $start -= ($end - $num_pages);
                    $end = $num_pages;
                }
            }

            if ($start > 1) {
                $output .= ' .... ';
            }

            for ($i = $start; $i <= $end; $i++) {
                if ($page == $i) {
                    $output .= ' <strong>' . $i . '</strong> ';
                } else {
                    $output .= ' <a href="' . str_replace('{page}', $i, $this->url) . '">' . $i . '</a> ';
                }
            }

            if ($end < $num_pages) {
                $output .= ' .... ';
            }
        }

        if ($page < $num_pages) {
            $output .= ' <a href="' . str_replace('{page}', $page + 1, $this->url) . '">' . $this->text_next . '</a> <a href="' . str_replace('{page}', $num_pages, $this->url) . '">' . $this->text_last . '</a> ';
        }

        $find = array(
            '{start}',
            '{end}',
            '{total}',
            '{pages}'
        );

        $replace = array(
            ($total) ? (($page - 1) * $limit) + 1 : 0,
            ((($page - 1) * $limit) > ($total - $limit)) ? $total : ((($page - 1) * $limit) + $limit),
            $total,
            $num_pages
        );

        return '<div class="' . $this->style_results . '">' . str_replace($find, $replace, $this->text) . '</div>';
    }
    
    public function getPrevLink() {
        $total = $this->total;

        $page = $this->getPage();
        
        $limit = $this->getLimit();
        
        $num_links = $this->num_links;
        $num_pages = $this->getNumPages();

        if ($page > 1)
        {
            return str_replace('{page}', $page-1, $this->url);
        }
        return false;
        
    }
    
    public function getNextLink() {
        $total = $this->total;

        $page = $this->getPage();
        
        $limit = $this->getLimit();
        
        $num_links = $this->num_links;
        $num_pages = $this->getNumPages();

        if ($page < $num_pages)
        {
            return str_replace('{page}', $page+1, $this->url);
        }
        return false;
        
    }

}

?>